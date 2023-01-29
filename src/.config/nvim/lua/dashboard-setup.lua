require("dashboard").setup({
  theme = 'doom',
  preview = {
      command = "lolcat-c",       -- preview command
    file_path = "~/.config/nvim/lua/startup-logo.txt",     -- preview file path,
    file_height = 34,   -- preview file height
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
