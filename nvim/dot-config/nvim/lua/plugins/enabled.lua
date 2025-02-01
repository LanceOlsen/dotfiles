return {
  {
    "jeetsukumaran/vim-indentwise"
  },
  {
    -- Autocomplete
    "hrsh7th/nvim-cmp",
  },
  {
    -- Git commands
    "tpope/vim-fugitive"
  },
  {
    -- Render markdown files in a browser window
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    -- Fancy start screen
    "mhinz/vim-startify",
    config = function()
      -- Configuration options for vim-startify
      vim.g.startify_session_autoload = 1
      vim.g.startify_session_persistence = 1
    end,
  },
  {
    -- Fuzzy file finder
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
    -- Display outer context by indentation at the top of the screen
    "wellle/context.vim"
  },
}
