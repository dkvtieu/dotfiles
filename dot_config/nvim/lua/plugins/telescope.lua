-- plugins/telescope.lua:
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            mappings = {
              i = {
                ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<cr>"] = require("telescope-undo.actions").restore,
              },
            },
          },
          advanced_git_search = {
            -- See Config
          },
        },
      })
      require("telescope").load_extension("undo")
      require("telescope").load_extension("advanced_git_search")
    end,
  },
}
