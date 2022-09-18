local set = vim.opt

vim.g.syntax            = true
set.termguicolors       = true

set.number              = true      -- lines in gutter
set.relativenumber      = true
set.clipboard           = "unnamed"
set.expandtab           = true      -- use spaces for tabs
set.softtabstop         = 2         -- 2 tabs space by default
set.shiftwidth          = 2         -- 2 tabs space by default
set.wrap                = false     -- no line wrap
set.splitbelow          = true      -- no weird vertical split position
set.splitright          = true      -- no weird horizontal split position 
set.shortmess           = "A"
set.ff                  = "unix"    -- Will make wsl experience less painfull
vim.g.asyncrun_open     = 6         -- In order to open the quickfix when asyncrun is launched

set.list								= true
set.listchars						= "tab:›\\ ,eol:¬,trail:⋅"

require("tokyonight").setup({
  style = "night",
  transparent = true,
  on_colors = function(colors)
    colors.border = "#fefefe"
    colors.bg_float = colors.none
  end
})
vim.cmd[[colorscheme tokyonight]]

