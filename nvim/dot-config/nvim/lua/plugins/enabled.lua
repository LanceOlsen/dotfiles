return {
  {
    "jeetsukumaran/vim-indentwise"
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp").setup({
        completion = {
          autocomplete = false,
        },
      })
    end,
  },
  {
    "tpope/vim-fugitive"
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "mhinz/vim-startify",
    config = function()
      -- Configuration options for vim-startify
      vim.g.startify_session_autoload = 1
      vim.g.startify_session_persistence = 1
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    opts = {
      defaults = {
        file_ignore_patterns = {
          "^widget/",
          "^app/assets/",
          "^vendor/",
          "rbs$",
          "^spec/javascripts/",
        },
      },
    },
  },
  {
    "wellle/context.vim"
  },
}
