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
  "tsserver",
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


require("lspconfig")["yamlls"].setup {
  on_attach = on_attach,
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
}



require("lspconfig")["gopls"].setup {
  on_attach = on_attach,
  cmd = { "gopls" },
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
    },
    staticcheck = true,
  }
}


require("lspconfig")["rust_analyzer"].setup { on_attach = on_attach }
require("lspconfig")["tflint"].setup { on_attach = on_attach }
require("lspconfig")["terraformls"].setup { on_attach = on_attach }
require("lspconfig")["tsserver"].setup { on_attach = on_attach }
require("lspconfig")["jsonls"].setup { on_attach = on_attach }
require("lspconfig")["html"].setup { on_attach = on_attach }
require("lspconfig")["eslint"].setup { on_attach = on_attach }
require("lspconfig")["dockerls"].setup { on_attach = on_attach }
require("lspconfig")["cmake"].setup { on_attach = on_attach }
require("lspconfig")["pyright"].setup { on_attach = on_attach }
require("lspconfig")["bashls"].setup { on_attach = on_attach }
require('lspconfig')["ansiblels"].setup { on_attach = on_attach }

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


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require('lspconfig')["lua_ls"].setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        path = runtime_path, -- Setup your lua path
      },
      diagnostics = {
        globals = {
          'vim',
          'use', -- Packer
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
      },
      telemetry = {
        enable = false,
      },
    }
  }
}
