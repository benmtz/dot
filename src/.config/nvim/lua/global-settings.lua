local set = vim.opt

vim.g.syntax            = true
set.termguicolors       = true

set.number              = true      -- lines in gutter
set.relativenumber      = true
set.clipboard           = "unnamed"
set.tabstop             = 2         -- 2 tabs space by default
set.softtabstop         = 2         -- 2 tabs space by default
set.shiftwidth          = 2         -- 2 tabs space by default
set.expandtab           = true      -- use spaces for tabs
set.wrap                = false     -- no line wrap
set.splitbelow          = true      -- no weird vertical split position
set.splitright          = true      -- no weird horizontal split position 
set.shortmess           = "AF"
set.ff                  = "unix"    -- Will make wsl experience less painfull
vim.g.asyncrun_open     = 6         -- In order to open the quickfix when asyncrun is launched
vim.g.floaterm_opener   = "edit"         -- In order to open the quickfix when asyncrun is launched

set.list								= true
set.listchars						= "tab:›\\ ,eol:¬,trail:⋅"

vim.g.tokyonight_colors = { fg_gutter = "#707cb2", comment = "#709db2", dark5 = "#709db2" }
require("tokyonight").setup({
  style = "night",
  transparent = true,
  floats = "dark",
  on_colors = function(colors)
    -- colors.fg_gutter = "#5081c0"
    colors.comment = "#709db2"
    colors.dark5 = "#709db2"
    colors.border = "#fefefe"
    colors.bg_float = colors.none
  end,
  on_highlights = function(hl, colors)
    hl.LineNr = {
      fg = "#ffba00"
      -- fg = "#5081c0"
    }
    hl.qfLineNr = {
      -- fg = "#737aa2"
      fg = "#ffba00"
    }
    hl.CursorLineNr = {
      fg = "#ffba00"
    }
  end
})
vim.cmd[[colorscheme tokyonight]]

