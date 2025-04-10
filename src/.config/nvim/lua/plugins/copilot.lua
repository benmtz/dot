return {
  {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({})
      end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = function()

      -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/main/lua/CopilotChat/prompts.lua
      local base_prompts = require("CopilotChat.config.prompts")

      return {
        debug = false, -- Enable debugging
        -- See Configuration section for rest
        prompts = {
          GitStage = {
            prompt = '> #git:staged\n\nSuggest optimizations about the code staged',
            system_prompt = 'You are a rockstar developer, specializing in cmake jenkins c++ and typescript. You do not hallucinate, and are very good at explaining context and giving sources. You know that sometimes it is ok to say that something is good enough.',
            description = 'Optimize my git staging area'
          },
          EdgeCase = {
            prompt = 'Find edge cases in the current buffer',
            system_prompt = 'You are a rockstar developer, specializing in cmake jenkins c++ and typescript. You do not hallucinate, and are very good at explaining context and giving sources, you are concise. You know that sometimes it is ok to say that something is good enough.',
            description = 'Find edge cases in the current buffer'
          },
          CodeSmells = {
            prompt = 'Find code smells cases in the current buffer',
            system_prompt = base_prompts.COPILOT_GENERATE,
            description = 'Find code smells in the current buffer'
          }
        }
      }
    end
  }
}

