" Currently YCM is very slow. Don't enable it when using terminal vim
let g:ycm_supported = has('gui_running')
" Unfortunately, eclim is quite heavy too. Enable it only for non gui vim
let g:eclim_supported = has('gui_running')
