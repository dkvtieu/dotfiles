return {
  {
    "echasnovski/mini.bufremove",
    version = "*",
    config = function()
      require("mini.bufremove").setup()
    end,
  },
  { "kevinhwang91/nvim-bqf" },
  { "bkad/CamelCaseMotion" },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        animate = {
          easing = "outCirc",
        },
      },
    },
  },
}
