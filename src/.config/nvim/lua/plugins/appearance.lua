return {
  { 'sheerun/vim-polyglot' },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    'MetriC-DT/balance-theme.nvim', -- has a light theme for outdoor sessions
    lazy = false,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd("colorscheme default") -- Set dark colorscheme here
      end,
      set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd("colorscheme monokai-nightasty") -- Use vim.cmd to set colorscheme
      end,
      update_interval = 3000,
      fallback = "dark",
    }
  },
  {
    "polirritmico/monokai-nightasty.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dark_style_background = "transparent", -- default, dark, transparent, #RRGGBB
      light_style_background = "default", -- default, dark, transparent, #RRGGBB
      color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
      lualine_bold = true, -- Lualine a and z sections font width
      lualine_style = "default", -- "dark", "light" or "default" (Follows dark/light style)
      markdown_header_marks = true, -- Add headers marks highlights (the `#` character) to Treesitter highlight query
      -- Style to be applied to selected syntax groups. See `:help nvim_set_hl`
      hl_styles = {
        keywords = { italic = true },
        comments = { italic = true },
        floats = "dark",
      },

      -- This also could be a table like this: `terminal_colors = { Normal = { fg = "#e6e6e6" } }`
      terminal_colors = function(colors)
        return { fg = colors.fg_dark }
      end,

      --- You can override specific color/highlights. Theme color values
      --- in `extras/palettes`. Also could be any hex RGB color you like.
      on_colors = function(colors)
        if vim.o.background == "light" then
          -- Custom colors for light theme
          colors.comment = "#2d7e79"
          colors.lualine.normal_bg = "#7ebd00"
        else
          -- Custom colors for dark theme
          colors.border = colors.magenta
          colors.lualine.normal_bg = colors.green
        end
      end,

      on_highlights = function(highlights, colors)
        -- You could add styles like bold, underline, italic
        highlights.TelescopeSelection = { bold = true }
        highlights.TelescopeBorder = { fg = colors.grey }
        highlights["@lsp.type.property.lua"] = { fg = colors.fg }
      end,
  },
  config = function(_, opts)
    -- Highlight line at the cursor position
    vim.opt.cursorline = true

    -- Default to dark theme
    vim.o.background = "dark"  -- dark | light

    -- Open new Nvim instances with the light theme when the sun hits the screen
    local date_output = vim.api.nvim_exec2("!date +'\\%H\\%M'", { output = true })
    local system_time = tonumber(string.match(date_output["output"], "%d%d%d%d"))
    if system_time >= 1345 and system_time < 1630 then
      vim.o.background = "light"
    end

    require("monokai-nightasty").load(opts)
  end,
  },
  { "folke/trouble.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' } }
}

