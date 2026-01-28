local wk = require("which-key")
local sys = require("current_environment")

local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local ensure_installed = {
  "bashls",
  "cmake",
  "dockerls",
  "eslint",
  "gopls",
  "pyright",
  "html",
  "jsonls",
  "ts_ls",
  "yamlls",
  "terraformls",
  "tflint"
}

if not sys.is_termux then
  table.insert(ensure_installed, "rust_analyzer")
  table.insert(ensure_installed, "lua_ls")
  table.insert(ensure_installed, "ansiblels")
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = ensure_installed
})


vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = { "*azure*ya?ml",
          ".pipelines*.yml", ".pipelines/*.yml" },
        ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/prometheus.json"] = { "*prom*.config.ya?ml",
          "*prometheus.ya?ml", "*prometheus.yml.j2" },
        ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/prometheus.rules.json"] = { "*prom*.rules.ya?ml" },
      }
    }
  }
})

vim.lsp.enable("ansiblels")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake")
vim.lsp.enable("dockerls")
vim.lsp.enable("eslint")
vim.lsp.enable("gopls")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("pyright")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("terraformls")
vim.lsp.enable("ts_ls")
vim.lsp.enable('tflint')

-- vim.api.nvim_exec([[ autocmd BufRead */ansible/*.yaml ]], false)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/ansible/*.yaml",
    "*/ansible/*.yml",
    "*/iasc-homelab-configuration/*.yaml",
    "*/iasc-ansible-common/*.yaml",
    "*/env-as-code/install.yaml"
  },
  command = "set ft=yaml.ansible",
})




vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
