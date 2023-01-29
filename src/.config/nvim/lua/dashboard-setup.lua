require("dashboard").setup({
  theme = 'doom',
  preview = {
    command = "~/.config/nvim/startup.sh",       -- preview command
    file_path = "not_needed",     -- preview file path,
    file_height = 40,   -- preview file height
    file_width = 67    -- preview file width
  },
  config = {
    center = {
      {
        icon = ' ',
        desc = 'Find Dotfiles',
        key = 'f',
        keymap = 'SPC f d',
        action = 'lua print(3)'
      },
    },
    footer = {}  --your footer
  }
})
