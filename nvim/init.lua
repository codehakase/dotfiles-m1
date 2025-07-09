vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("set relativenumber")
vim.cmd("set number")
--vim.cmd("set textwidth=80")
vim.cmd("set diffopt+=vertical")
vim.cmd("set colorcolumn=0")
vim.cmd("set smarttab")
vim.cmd("set mouse=a")
vim.cmd("inoremap jk <Esc>")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.cmd("set expandtab")
vim.o.background = "dark"
vim.opt.inccommand = 'split'

-- sync clipboard with os
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Plugins
local plugins = {
  {
    "ellisonleao/gruvbox.nvim", 
    priority = 1000 , 
    config = function ()
        require("gruvbox").setup({
          contrast = "hard"
        })
      vim.cmd([[colorscheme gruvbox]])
    end,
    opts = ...
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {"hrsh7th/cmp-vsnip"},
  {"neovim/nvim-lspconfig"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},
  {"hrsh7th/cmp-cmdline"},
  {"hrsh7th/nvim-cmp"},
  {"hrsh7th/cmp-vsnip"},
  {"hrsh7th/vim-vsnip"},
  {"lewis6991/gitsigns.nvim", 
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    }
  },
  {"lukas-reineke/indent-blankline.nvim"},
  {"nvim-lualine/lualine.nvim"},
  {'wakatime/vim-wakatime', lazy = false },
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^4',
    lazy = false, 
  },
  {"github/copilot.vim"},
}
local opts = {}

require("lazy").setup(plugins, opts)


-- Telescope
require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "%.min%.js$",
      "%.min%.css$"
    }
  }
})
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Treesitter
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = { 
    "go", 
    "lua", 
    "haskell", 
    "typescript",
    "html",
    "css", 
    "javascript",
  },
  highlight = { enable = true },
  indent = { enable = true },
})

-- statusline
require('lualine').setup({
  options = {
    icons_enbled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{ 'filename', file_status = true, path = 1 }},
    lualine_x = {
      {
        'diagnostics', 
        sources = { 'nvim_diagnostic', 'nvim_lsp'},
        symbols = { error = '', warn = '', info = '', hint = ''}
      },
      'encoding', 'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{ 'filename', file_status = true, path = 1}},
    lualine_x = { 'location'},
    lualine_y = {},
    lualine_z = {},
  }
})

-- Enable indent-blankline
require("ibl").setup()

-- cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', function()
    vim.cmd('split')
    vim.lsp.buf.definition()
  end, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end

-- Set up lspconfig.
--
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- require('lspconfig')['hls'].setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   flags = lsp_flags,
--   settings = {
--     haskell = {
--       formattingProvider = "fourmolu"
--     }
--   }
-- }

require('lspconfig')['gopls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

require('lspconfig')['tailwindcss'].setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

-- Neotree
vim.cmd("nmap <F1> :Neotree toggle<CR>")
vim.cmd("nmap <leader><space> :Neotree toggle<CR>")
require('neo-tree').setup({
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    icon = {
      -- folder_closed = "*",
      -- folder_open = "*",
      -- folder_empty = "*",
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
  }
})
