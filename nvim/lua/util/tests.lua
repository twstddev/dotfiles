local M = {}

-- Directories that hold test code (`/test/` also covers Maven/Gradle's `src/test`)
local DIRS = { "/test/", "/tests/", "/__tests__/", "/src/testFixtures/" }

-- File names of tests that live next to the code they test, or outside a test directory
local NAMES = {
  "%.test%.%w+$", -- foo.test.ts
  "%.spec%.%w+$", -- foo.spec.ts
  "_test%.%w+$", -- foo_test.go, foo_test.py
  "^test_.*%.py$", -- test_foo.py
  "Tests?%.java$", -- FooTest.java, FooTests.java, FooIntegrationTest.java
  "Tests?%.kt$",
  "Tests?%.groovy$",
  "IT%.java$", -- FooIT.java (Maven Failsafe)
  "IT%.kt$",
  "IT%.groovy$",
  "Spec%.groovy$", -- Spock
}

---@param path? string
---@return boolean
function M.is_test_file(path)
  if not path or path == "" then
    return false
  end
  path = vim.fs.normalize(path)
  -- match directories relative to the project, so a project living under e.g. ~/test/ isn't all tests.
  -- uv.cwd() instead of getcwd(): grep runs this in a fast event, where Vimscript functions error
  local rel = "/" .. (vim.fs.relpath(vim.uv.cwd() or "", path) or path)
  for _, dir in ipairs(DIRS) do
    if rel:find(dir, 1, true) then
      return true
    end
  end
  local name = vim.fs.basename(path)
  for _, pattern in ipairs(NAMES) do
    if name:find(pattern) then
      return true
    end
  end
  return false
end

return M
