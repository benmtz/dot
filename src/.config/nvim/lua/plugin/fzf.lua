vim.pack.add({{
  src = 'https://github.com/ibhagwan/fzf-lua',
  version = 'main'
}
})

local actions = require("fzf-lua").actions
require("fzf-lua").setup({
  fzf_opts = {
    ["--walker"] = "file,follow,hidden"
  },
  files = {
    actions = {
      ["ctrl-h"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
    }
  },
  buffers= {
    actions = {
      ["ctrl-h"] = actions.buf_split,
      ["ctrl-v"] = actions.buf_vsplit,
      ["ctrl-t"] = actions.buf_tabedit,
    }
  }
})
