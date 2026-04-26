vim.pack.add({{
  src = 'https://github.com/f-person/git-blame.nvim',
  version = 'main'
},
})
require('gitblame').setup({
    enabled = true,
    message_template = "<author> • <summary> • <date> • <<sha>>",
    date_format = "%m-%d-%Y %H:%M:%S",
    virtual_text_column = 1,
})

