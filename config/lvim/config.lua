-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

lvim.log.level = "warn"
local themes = {
  "gruvbox", "github_dark", "monokai", "material", "tokyonight", "monokai_pro", "material-darker", "eldritch",
  "onedark"
}

math.randomseed(os.clock())
lvim.colorscheme = themes[math.random(1, #themes)]
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = themes[math.random() % (table.getn(themes) - 1 ) ]

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "autopep8", filetypes = { "python" } },
  --   { command = "isort", filetypes = { "python" } },
  --   {
  --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --     command = "prettier",
  --     ---@usage arguments to pass to the formatter
  --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --     extra_args = { "--print-with", "100" },
  --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --     filetypes = { "typescript", "typescriptreact" },
  --   },
}
-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
}
-- Additional Plugins
lvim.plugins = {
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      -- vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      -- vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  { 'ethanholz/nvim-lastplace' },
  { 'chentoast/marks.nvim' },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },
  {
    "tpope/vim-surround",

    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --  vim.o.timeoutlen = 500
    -- end
  },
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  },
  { "ellisonleao/gruvbox.nvim"
  },
  { 'tanvirtin/monokai.nvim'
  },
  {
    'marko-cerovac/material.nvim'
  },
  {
    'projekt0n/github-nvim-theme'
  },
  {
    'eldritch-theme/eldritch.nvim'
  },
  {
    'navarasu/onedark.nvim'
  },
  {
    'stevearc/aerial.nvim'
  },
  {
  "rawnly/gist.nvim",
  config = function() require("gist").setup() end,
  -- `GistsList` opens the selected gif in a terminal buffer,
  -- this plugin uses neovim remote rpc functionality to open the gist in an actual buffer and not have buffer inception
  dependencies = { "samjwill/nvim-unception", setup = function() vim.g.unception_block_while_host_edits = true end }
},
{'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'}
  -- {
  --   'nvim-focus/focus.nvim',
  --   config = function()
  --     require("focus").setup()
  --   end
  -- }
  -- {
  --   "SmiteshP/nvim-navbuddy",
  --   dependencies = {
  --       "neovim/nvim-lspconfig",
  --       "SmiteshP/nvim-navic",
  --       "MunifTanjim/nui.nvim",
  --       "numToStr/Comment.nvim",        -- Optional
  --       "nvim-telescope/telescope.nvim" -- Optional
  --   },
}
-- local navbuddy = require("nvim-navbuddy")

-- require("lspconfig").clangd.setup {
--     on_attach = function(client, bufnr)
--         navbuddy.attach(client, bufnr)
--     end
-- }
require 'nvim-lastplace'.setup {}
require 'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions.
  -- higher values will have better performance but may cause visual lag,
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}

}
-- Telescope
lvim.keys.normal_mode["<Leader>tt"] = ":Telescope tags<CR>"
lvim.keys.normal_mode["<Leader>tm"] = ":Telescope marks<CR>"
lvim.keys.normal_mode["<Leader>tb"] = ":Telescope buffers<CR>"
lvim.keys.normal_mode["<Leader>tg"] = ":Telescope live_grep<CR>"

-- Hop
lvim.keys.normal_mode["<Leader>hc"] = ":HopChar1<CR>"
lvim.keys.normal_mode["<Leader>hl"] = ":HopLine<CR>"

local vim = vim
local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

local init_custom_options = function()
  local custom_options = {
    relativenumber = true, -- Set relative numbered lines
    colorcolumn = "120", -- Indent line at what column? Set something like '99999' to not display it
  }

  for k, v in pairs(custom_options) do
    vim.opt[k] = v
  end
end
init_custom_options()
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
lvim.keys.normal_mode["<leader>a"] =  ":AerialToggle!<CR>"

 vim.g.unception_block_while_host_edits = true
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Option 1: coc.nvim as LSP client
-- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
require('ufo').setup()
--

-- Option 2: nvim lsp as LSP client
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup()
--

-- Option 3: treesitter as a main provider instead
-- (Note: the `nvim-treesitter` plugin is *not* needed.)
-- ufo uses the same query files for folding (queries/<lang>/folds.scm)
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})
--

-- Option 4: disable all providers for all buffers
-- Not recommend, AFAIK, the ufo's providers are the best performance in Neovim
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return ''
    end
})
