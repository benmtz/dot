return {
  { 'junegunn/fzf.vim',
    lazy = false ,
    dependencies = {
      'junegunn/fzf'
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
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
    end
  }
}

