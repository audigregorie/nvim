return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- Safely load ChatGPT.nvim to avoid runtime errors
    local ok, chatgpt = pcall(require, "chatgpt")
    if not ok then
      vim.notify("ChatGPT.nvim not found!", vim.log.levels.ERROR)
      return
    end

    chatgpt.setup({
      api_key_cmd = "pass show openai", -- Command to retrieve OpenAI API key securely
      -- Additional configuration options can be added here
      -- e.g., api_key = "your-api-key" -- (Direct API key, if not using a secure store)
      -- response_format = "markdown", -- Define response format (e.g., plaintext, markdown)
    })
  end,
}

