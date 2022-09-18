local k = require('keymap')
-- local capabilities = require('autocompletion')

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', k.issue_show, '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', k.issue_previous, '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', k.issue_next, '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', k.issue_list, '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_declaration, '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_definition, '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_hover, '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_implementation,  '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_signature_help, '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', k.type_definition, '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_rename_symbol, '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_action, '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_references, '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', k.code_format, '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
      "ansiblels",
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
      "tflint",
      "sumneko_lua",
      "rust_analyzer"
    }
})


require("lspconfig")["rust_analyzer"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["tflint"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["terraformls"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["yamlls"].setup {
  on_attach = on_attach,
  -- -- capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
          ["https://dev.azure.com/benmertz/_apis/distributedtask/yamlschema"] = {"*azure*ya?ml"},
          ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/prometheus.json"] = {"*prom*.config.ya?ml","*prometheus.ya?ml", "*prometheus.yml.j2"},
          ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/prometheus.rules.json"] = {"*prom*.rules.ya?ml"},
      }
    }
  }
}


require("lspconfig")["tsserver"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["jsonls"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["html"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["gopls"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
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


require("lspconfig")["eslint"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["dockerls"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["cmake"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["pyright"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require("lspconfig")["bashls"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}


require('lspconfig')["ansiblels"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
}
-- vim.api.nvim_exec([[ autocmd BufRead */ansible/*.yaml ]], false)
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  pattern = {
    "*/ansible/*.yaml",
    "*/ansible/*.yml",
    "*/iasc-homelab-configuration/*.yaml",
    "*/iasc-ansible-common/*.yaml",
    "*/env-as-code/install.yaml"
  },
  command = "set ft=yaml.ansible",
})


require('lspconfig')["sumneko_lua"].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      }
    }
}



