-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Reload changed files when focusing in (useful when changing branches)
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.cmd("checktime")
  end,
})

-- Require solargraph
require("lspconfig").solargraph.setup({
  on_attach = function(client)
    client.server_capabilities.documentHighlightProvider = false
  end,
  settings = {
    solargraph = {
      autoformat = false,
      formatting = false,
    },
  },
  init_options = {
    autoformat = false,
    formatting = false,
  },
})

-- Setup for vim-cmp
local cmp = require('cmp')
cmp.setup({
  completion = {
    autocomplete = false,
  },
  mapping = {
    -- Use <Tab> to manually trigger completion
    ['<S-Tab>'] = cmp.mapping(function()
      if not cmp.visible() then
        cmp.complete()
      end
    end, {'i','s'}),
  },
})


-- Setup for telescope
local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")
telescope.setup({
  extensions = {
    live_grep_args = {
      auto_quoting = false,
    },
  },
})
telescope.load_extension("live_grep_args")

-- Use / to search tree like a normal buffer
require("neo-tree").setup({
  -- Close neo-tree after selecting a file
  event_handlers = {
    {
      event = "file_open_requested",
      handler = function()
        -- auto close
        -- vim.cmd("Neotree close")
        -- OR
        require("neo-tree.command").execute({ action = "close" })
      end
    },
  },
  window = {
    mappings = {
      -- Disable highlighting when searching in the neo-tree split
      ["/"] = function(state)
        local hlsearch = vim.v.hlsearch -- Save the current state of search highlighting
        vim.api.nvim_command("set nohlsearch") -- Disable search highlighting
        vim.api.nvim_command("wincmd p")
        vim.api.nvim_command("setlocal nornu nonu")
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("/", true, false, true), "n", true)
        vim.api.nvim_command("wincmd p")
        if hlsearch == 1 then
          vim.api.nvim_command("set hlsearch") -- Re-enable search highlighting if it was originally enabled
        end
      end,
    },
  },
})

-------------------------
-- BUILTIN VIM OPTIONS --
-------------------------

vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.colorcolumn = "121"
vim.opt.winbar = "%=%m %f"
vim.opt.hidden = false -- Prevent changing buffers without saving

--------------------
-- NEOVIM OPTIONS --
--------------------

-- White border between splits
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff" })

-------------------------
-- KEY BINDINGS --
-------------------------

-- source this file
vim.keymap.set("n", "<leader>vs", ":source $MYVIMRC<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ve", ":e $MYVIMRC<CR>", { noremap = true, silent = true })

-- open split up
vim.keymap.set("n", "˚", ":sp<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "˚", ":sp<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "˚", ":sp<CR>", { noremap = true, silent = true })

-- open split down
vim.keymap.set("n", "∆", ":sp<CR><C-W><C-J>", { noremap = true, silent = true })
vim.keymap.set("i", "∆", ":sp<CR><C-W><C-J>", { noremap = true, silent = true })
vim.keymap.set("v", "∆", ":sp<CR><C-W><C-J>", { noremap = true, silent = true })

-- open split left
vim.keymap.set("n", "˙", ":vs<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "˙", ":vs<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "˙", ":vs<CR>", { noremap = true, silent = true })

-- open split right
vim.keymap.set("n", "¬", ":vs<CR><C-W><C-L>", { noremap = true, silent = true })
vim.keymap.set("i", "¬", ":vs<CR><C-W><C-L>", { noremap = true, silent = true })
vim.keymap.set("v", "¬", ":vs<CR><C-W><C-L>", { noremap = true, silent = true })

-- close other splits
vim.keymap.set("n", "<leader>o", ":only<CR>", { noremap = true, silent = true })

-- moving lines up and down
vim.keymap.set("n", "<D-j>", "ddp", { noremap = true, silent = true })
vim.keymap.set("n", "<D-k>", "ddpP", { noremap = true, silent = true })

--copy rspec command for current file
vim.keymap.set("n", "<leader>rf", ":!echo 'rspec %' <bar> pbcopy<CR><CR>", { noremap = true, silent = true })

-- copy rspec command for current file (fail fast)
vim.keymap.set(
  "n",
  "<leader>ra",
  ":!echo 'rspec --fail-fast %' <bar> pbcopy<CR><CR>",
  { noremap = true, silent = true }
)

-- copy rspec command for current line
vim.keymap.set(
  "n",
  "<leader>rl",
  ':exe "!echo \'rspec %\':" . line(".") . "<bar> pbcopy"<CR><CR>',
  { noremap = true, silent = true }
)

-- copy github line for the current line
vim.keymap.set(
  "n",
  "<leader>hl",
  ":exe '!echo https://github.com/squareup/appointments/blob/master/%' . '\\#L' . line('.') . ' | pbcopy'<CR>",
  { noremap = true, silent = true }
)

-- copy github line for the current file
vim.keymap.set(
  "n",
  "<leader>hf",
  ":exe '!echo https://github.com/squareup/appointments/blob/master/%' . ' | pbcopy'<CR>",
  { noremap = true, silent = true }
)

-- copy current filename to clipboard
vim.keymap.set("n", "<leader>yf", ":!echo -n '%' <bar> pbcopy<CR><CR>", { noremap = true, silent = true })

-- yank entire file to default and z registers
vim.keymap.set("n", "<leader>ya", 'ggVGyVG"zy', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>p", "obinding.pry<ESC>:w<CR>", { noremap = true, silent = true })

-- Go to definition
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- use live args extension for telescope
vim.api.nvim_set_keymap(
  "n",
  "<leader>sg",
  "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>E", "<cmd>Neotree reveal<CR>", { noremap = true, silent = true })
