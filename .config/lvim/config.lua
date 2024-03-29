--[[                               _
| |   _   _ _ __   __ _ _ ____   _(_)_ __ ___
| |  | | | | '_ \ / _` | '__\ \ / / | '_ ` _ \
| |__| |_| | | | | (_| | |   \ V /| | | | | | |
|_____\__,_|_| |_|\__,_|_|    \_/ |_|_| |_| |_|]]
--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "everforest"
lvim.transparent_window = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

--[[         _   _
  ___  _ __ | |_(_) ___  _ __  ___
 / _ \| '_ \| __| |/ _ \| '_ \/ __|
| (_) | |_) | |_| | (_) | | | \__ \
 \___/| .__/ \__|_|\___/|_| |_|___/
      |_| ]]
vim.opt.foldmethod = "expr"                     -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to
vim.opt.foldlevel = 3

vim.g.python3_host_prog = "~/.config/lvim/venv/bin/python3"

function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

--
-- keymappings [view all the defaults by pressing <leader>Lk]
--
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode[","] = "za"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- dashboard configuration
local alpha = lvim.builtin.alpha
local dashboard = alpha.dashboard
local dash_util = require("alpha.themes.dashboard")

alpha.active = true
alpha.mode = "dashboard"

dashboard.section.header.val = {
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
  dash_util.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dash_util.button("f", "  Find File", ":Telescope find_files <CR>"),
  dash_util.button("c", "  Configuration", ":e ~/.config/lvim/config.lua <CR>"),
  dash_util.button("l", "  Lazy", ":Lazy <CR>"),
  dash_util.button("q", "  Quit NVIM", ":qa<CR>"),
}

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "json",
  "lua",
  "python",
  "css",
  "rust",
  "java",
  "yaml",
  "markdown",
  "markdown_inline",
  "julia",
}

lvim.builtin.treesitter.ignore_install = { "haskell", "help" }
lvim.builtin.treesitter.highlight.enable = true

--[[
 _     ____  ____
| |   / ___||  _ \
| |   \___ \| |_) |
| |___ ___) |  __/
|_____|____/|_| ]]
-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "lua_ls",
  "pyright",
}

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "markdown", "quarto" },
  },
})

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "ruff", filetypes = { "python" } },
})

--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

--[[   _             _
 _ __ | |_   _  __ _(_)_ __  ___
| '_ \| | | | |/ _` | | '_ \/ __|
| |_) | | |_| | (_| | | | | \__ \
| .__/|_|\__,_|\__, |_|_| |_|___/
|_|            |___/ ]]
local programming_ftypes = { "bash", "c", "css", "go", "javascript", "json", "lua", "python", "rust", "tsx", "typescript" }
local my_plugins = {}


my_plugins.colorschemes = {
  {
    "sainnhe/sonokai",
    config = function()
      vim.cmd([[
        let g:sonokai_better_performance = 1
        " let g:sonokai_style = 'maia'
        let g:sonokai_style = 'espresso'
      ]])
    end,
  },
  {
    "sainnhe/everforest",
    config = function()
      vim.cmd([[
          let g:everforest_transparent_background = 1
          let g:everforest_dim_inactive_windows = 1

        ]])
    end,
  },
}

my_plugins.core = {
  {
    "declancm/cinnamon.nvim",
    config = function()
      require("cinnamon").setup({
        extra_keymaps = true,
        override_keymaps = true,
        max_length = 500,
        scroll_limit = 500,
      })
    end,
  },
  {
    'nvim-tree/nvim-web-devicons'
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        keys = function()
          return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
        end,
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
}

my_plugins.treesitter = {
  -- {
  --   "p00f/nvim-ts-rainbow",
  -- },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {
          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            "class",
            "function",
            "method",
          },
        },
      })
    end,
  },
}

my_plugins.misc = {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({})
    end,
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    dependencies = {
      {
        "3rd/image.nvim",
        event = "VeryLazy",
        dependencies = {
          { "nvim-treesitter/nvim-treesitter" }
        },
        config = function()
          -- default config
          require("image").setup({
            -- backend = "ueberzug",
            backend = "kitty",
            integrations = {
              markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = false,
                filetypes = { "markdown", "quarto" }, -- markdown extensions (ie. quarto) can go here
              },
              neorg = { enabled = false },
            },
            max_width = 100,
            max_height = 12,
            max_width_window_percentage = math.huge,
            max_height_window_percentage = math.huge,
            window_overlap_clear_enabled = true,                                                -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            editor_only_render_when_focused = false,                                            -- auto show/hide images when the editor gains/looses focus
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.html" }, -- render image files as images when opened
          })
        end,
      }
    },
    ft = { 'python' },
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_auto_open_html_in_browser = true
      vim.g.molten_show_mimetype_debug = true
    end,
    config = function()
      vim.keymap.set("n", "<localleader>ip", function()
        local venv = os.getenv("CONDA_DEFAULT_ENV")
        if venv ~= nil then
          -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
          -- venv = string.match(venv, "/.+/(.+)")
          vim.cmd(("MoltenInit %s"):format(venv))
        else
          vim.cmd("MoltenInit python3")
        end
      end, { desc = "Initialize Molten for python3", silent = true })
    end
  }
}

my_plugins.assistants = {
  -- {
  --   'Exafunction/codeium.vim',
  --   config = function()
  --     vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
  --     vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
  --     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
  --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  --   end
  -- }
}


-- used in merging all the plugin tables
local function append_table(a, b)
  local result = a
  for i = 1, #b do
    table.insert(result, b[i])
  end
  return result
end

-- Plugins on top of Lunarvim
local plugins = {}
for name, plugin_table in pairs(my_plugins) do
  plugins = append_table(plugins, plugin_table)
end

lvim.plugins = plugins


-- adds luarocks to the package path
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

--[[
  __ _ _   _| |_ ___   ___ _ __ ___   __| |___
 / _` | | | | __/ _ \ / __| '_ ` _ \ / _` / __|
| (_| | |_| | || (_) | (__| | | | | | (_| \__ \
 \__,_|\__,_|\__\___/ \___|_| |_| |_|\__,_|___/ ]]
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

lvim.autocommands = {}
