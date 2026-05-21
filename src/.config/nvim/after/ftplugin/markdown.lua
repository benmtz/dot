vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

local md = require("md")
vim.keymap.set("n", "oo", md.insert_note_line, { buffer = true, desc = "Insert timestamped note line" })

