return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "rcasia/neotest-java",
    -- "thenbe/neotest-playwright",
  },
  opts = {
    adapters = {
      "neotest-jest",
      "neotest-vitest",
      "neotest-java",
      -- ["neotest-playwright"] = {
      --   persist_project_selection = true,
      --   enable_dynamic_test_discovery = true,
      -- },
    },
  },
}
