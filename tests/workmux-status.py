import fcntl
import json
import os
from pathlib import Path
import pty
import select
import shutil
import struct
import subprocess
import tempfile
import termios
import time

repo = Path(__file__).resolve().parents[1]
tmux = shutil.which('tmux')
workmux = shutil.which('workmux')
assert tmux and workmux, 'Install tmux and workmux before running this test'
with tempfile.TemporaryDirectory(prefix='workmux-focus-check-') as temporary:
    root = Path(temporary)
    home = root / 'home'
    (home / '.config').mkdir(parents=True)
    (home / '.config/tmux').symlink_to(repo / 'tmux')
    (home / '.config/workmux').symlink_to(repo / 'workmux')
    socket = str(root / 'tmux.sock')
    env = dict(os.environ, HOME=str(home), XDG_CONFIG_HOME=str(home / '.config'),
               XDG_STATE_HOME=str(root / 'state'), XDG_CACHE_HOME=str(root / 'cache'),
               TERM='xterm-256color')
    env.pop('TMUX', None)
    env.pop('TMUX_PANE', None)
    def run(*args, check=True):
        return subprocess.run([tmux, '-S', socket, *args], env=env,
                              capture_output=True, text=True, check=check)
    master = slave = client = None
    def pump(duration=0.1):
        deadline = time.monotonic() + duration
        while time.monotonic() < deadline:
            if select.select([master], [], [], 0.02)[0]:
                os.read(master, 65536)
    try:
        observer = run('-f', '/dev/null', 'new-session', '-d', '-P', '-F', '#{pane_id}', '-s', 'check', '/bin/cat').stdout.strip()
        agent = run('split-window', '-d', '-P', '-F', '#{pane_id}', '-t', observer, '/bin/cat').stdout.strip()
        run('set-option', '-g', 'default-shell', '/bin/sh')
        run('source-file', str(repo / 'tmux/options.conf'))
        run('source-file', str(repo / 'tmux/bindings.conf'))
        pid = run('display-message', '-p', '#{pid}').stdout.strip()
        agent_env = dict(env, TMUX=f'{socket},{pid},0', TMUX_PANE=agent)
        subprocess.run([workmux, 'register-agent'], env=agent_env, stdin=subprocess.DEVNULL, check=True)
        master, slave = pty.openpty()
        fcntl.ioctl(slave, termios.TIOCSWINSZ, struct.pack('HHHH', 40, 140, 0, 0))
        client = subprocess.Popen([tmux, '-S', socket, 'attach-session', '-t', 'check'], env=env, stdin=slave, stdout=slave, stderr=slave)
        pump(0.2)
        def summary():
            return subprocess.run(['/bin/sh', str(repo / 'tmux/workmux-status.sh')], env=agent_env,
                                  capture_output=True, text=True, check=True).stdout
        def set_status(status):
            subprocess.run([workmux, 'set-window-status', status], env=agent_env, stdin=subprocess.DEVNULL, check=True)
        for status in ('done', 'waiting'):
            run('select-pane', '-t', observer)
            pump()
            set_status(status)
            before = summary()
            assert before.strip(), f'{status} must show before acknowledgement'
            run('select-pane', '-t', agent)
            pump(0.3)
            after = summary()
            assert not after.strip(), f'{status} indicator remains after focusing its agent pane: {after!r}'
            run('select-pane', '-t', observer)
            pump()
            assert not summary().strip(), f'acknowledged {status} returns after leaving pane'
            observation = json.loads(subprocess.check_output([workmux, 'status', '--all', '--json'], env=agent_env, text=True))
            assert [a['status'] for a in observation['agents']] == [status], 'display must not rewrite agent lifecycle status'
            print(f'PASS: {status} clears on focus and stays cleared after leaving', flush=True)
            run('select-pane', '-t', agent)
            pump()
            set_status(status)
            assert not summary().strip(), f'{status} must stay clear when already focused'
            print(f'PASS: {status} while already focused needs no extra focus event', flush=True)
        set_status('working')
        assert summary().strip(), 'working must show while focused'
        run('select-pane', '-t', observer)
        pump()
        run('select-pane', '-t', agent)
        pump()
        assert summary().strip(), 'working must survive focus changes'
        print('PASS: working remains visible while focused', flush=True)
        run('select-pane', '-t', observer)
        pump()
        sibling = run('split-window', '-d', '-P', '-F', '#{pane_id}', '-t', observer, '/bin/cat').stdout.strip()
        sibling_env = dict(agent_env, TMUX_PANE=sibling)
        subprocess.run([workmux, 'register-agent'], env=sibling_env, stdin=subprocess.DEVNULL, check=True)
        set_status('done')
        subprocess.run([workmux, 'set-window-status', 'done'], env=sibling_env, stdin=subprocess.DEVNULL, check=True)
        assert '󱜚 2' in summary(), 'both background panes need acknowledgement'
        run('select-pane', '-t', agent)
        pump()
        assert '󱜚 1' in summary(), 'focusing one agent must not clear its sibling'
        run('select-pane', '-t', sibling)
        pump()
        assert not summary().strip(), 'each pane must acknowledge independently'
        print('PASS: two agents in one window acknowledge independently', flush=True)
    finally:
        run('kill-server', check=False)
        if client:
            client.wait(timeout=5)
        if master is not None:
            os.close(master)
        if slave is not None:
            os.close(slave)
