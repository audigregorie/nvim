return {
  "Oldenborg/vim-px-to-rem",

  -- Load only for web development files
  ft = { "html", "css", "scss", "sass", "less", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },

  config = function()
    -- Check if the plugin is installed
    local function plugin_installed()
      return vim.fn.exists("g:loaded_px_to_rem") > 0 or vim.fn.findfile("plugin/px-to-rem.vim", vim.o.runtimepath) ~= ""
    end

    -- Set up configurations with error handling
    local function setup_config()
      -- Default base font size for calculations (16px is standard)
      vim.g.px_to_rem_base_font_size = vim.g.px_to_rem_base_font_size or 16

      -- Configure precision (number of decimal places)
      vim.g.px_to_rem_precision = vim.g.px_to_rem_precision or 4

      -- Whether to keep the original unit as a comment
      vim.g.px_to_rem_keep_original_comment = vim.g.px_to_rem_keep_original_comment or 1
    end

    -- Set up key mappings with error handling
    local function setup_keymaps()
      -- Use the more modern vim.keymap.set instead of nvim_set_keymap

      -- Convert px to rem (normal mode)
      vim.keymap.set("n", "<leader>pr", function()
        if plugin_installed() then
          vim.cmd("Rem")
        else
          vim.notify("vim-px-to-rem plugin not found!", vim.log.levels.ERROR)
        end
      end, { desc = "Convert px to rem" })

      -- Convert rem to px (normal mode)
      vim.keymap.set("n", "<leader>rp", function()
        if plugin_installed() then
          vim.cmd("Px")
        else
          vim.notify("vim-px-to-rem plugin not found!", vim.log.levels.ERROR)
        end
      end, { desc = "Convert rem to px" })

      -- Convert px to rem (visual mode)
      vim.keymap.set("v", "<leader>pr", function()
        if plugin_installed() then
          vim.cmd("'<,'>Rem")
        else
          vim.notify("vim-px-to-rem plugin not found!", vim.log.levels.ERROR)
        end
      end, { desc = "Convert px to rem (visual)" })

      -- Convert rem to px (visual mode)
      vim.keymap.set("v", "<leader>rp", function()
        if plugin_installed() then
          vim.cmd("'<,'>Px")
        else
          vim.notify("vim-px-to-rem plugin not found!", vim.log.levels.ERROR)
        end
      end, { desc = "Convert rem to px (visual)" })
    end

    -- Create commands for easier access
    local function setup_commands()
      -- Command to change the base font size
      vim.api.nvim_create_user_command("PxRemBase", function(opts)
        if #opts.args > 0 then
          local base_size = tonumber(opts.args)
          if base_size and base_size > 0 then
            vim.g.px_to_rem_base_font_size = base_size
            vim.notify("Base font size set to " .. base_size .. "px", vim.log.levels.INFO)
          else
            vim.notify("Invalid base font size. Please provide a positive number.", vim.log.levels.ERROR)
          end
        else
          vim.notify("Current base font size: " .. (vim.g.px_to_rem_base_font_size or 16) .. "px", vim.log.levels.INFO)
        end
      end, { nargs = "?", desc = "Set base font size for px/rem conversion" })

      -- Command to toggle keeping original as comment
      vim.api.nvim_create_user_command("PxRemToggleComment", function()
        if vim.g.px_to_rem_keep_original_comment == 1 then
          vim.g.px_to_rem_keep_original_comment = 0
          vim.notify("Original values will not be kept as comments", vim.log.levels.INFO)
        else
          vim.g.px_to_rem_keep_original_comment = 1
          vim.notify("Original values will be kept as comments", vim.log.levels.INFO)
        end
      end, { desc = "Toggle keeping original values as comments" })
    end

    -- Set up autocommands for enhanced functionality
    local function setup_autocommands()
      local group = vim.api.nvim_create_augroup("PxRemPlugin", { clear = true })

      -- Detect project configuration files
      vim.api.nvim_create_autocmd("BufReadPost", {
        group = group,
        pattern = { ".pxremrc", ".pxremrc.json" },
        callback = function()
          -- Try to load project-specific settings
          local ok, content = pcall(vim.fn.readfile, vim.fn.expand("%:p"))
          if ok then
            local parsed_ok, settings = pcall(vim.fn.json_decode, table.concat(content, "\n"))
            if parsed_ok and type(settings) == "table" then
              if settings.base_font_size then
                vim.g.px_to_rem_base_font_size = tonumber(settings.base_font_size)
              end
              if settings.precision then
                vim.g.px_to_rem_precision = tonumber(settings.precision)
              end
              if settings.keep_original_comment ~= nil then
                vim.g.px_to_rem_keep_original_comment = settings.keep_original_comment and 1 or 0
              end
              vim.notify("Loaded px-to-rem project settings", vim.log.levels.INFO)
            end
          end
        end,
      })

      -- Set up filetype-specific settings
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = { "css", "scss", "sass", "less" },
        callback = function()
          -- Add buffer-local keymaps for quick conversions
          vim.keymap.set("n", "<localleader>p", function()
            vim.cmd("Rem")
          end, { buffer = true, desc = "Convert px to rem (buffer)" })

          -- Convert whole file command
          vim.api.nvim_buf_create_user_command(0, "RemAll", function()
            vim.cmd("%Rem")
          end, { desc = "Convert all px to rem in file" })

          vim.api.nvim_buf_create_user_command(0, "PxAll", function()
            vim.cmd("%Px")
          end, { desc = "Convert all rem to px in file" })
        end,
      })
    end

    -- Run all setup functions
    setup_config()
    setup_keymaps()
    setup_commands()
    setup_autocommands()

    -- Defer a check to make sure the plugin is loaded
    vim.defer_fn(function()
      if not plugin_installed() then
        vim.notify("Warning: vim-px-to-rem plugin might not be properly installed.", vim.log.levels.WARN)
      end
    end, 1000)
  end,

  -- Add a helpful help text for reference
  -- Usage Tips:
  -- :Rem - Convert px values to rem in current line
  -- :Px - Convert rem values to px in current line
  -- :'<,'>Rem - Convert selected lines from px to rem
  -- :'<,'>Px - Convert selected lines from rem to px
  -- :%Rem - Convert entire file from px to rem
  -- :%Px - Convert entire file from rem to px
  -- :PxRemBase 16 - Set the base font size to 16px
  -- :PxRemToggleComment - Toggle keeping original values as comments
}
