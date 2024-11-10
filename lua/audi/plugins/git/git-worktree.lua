return {
  "ThePrimeagen/git-worktree.nvim",
  config = function()
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
      vim.notify("Telescope not found", vim.log.levels.ERROR)
      return
    end

    local worktree_ok, worktree = pcall(require, "git-worktree")
    if not worktree_ok then
      vim.notify("Git Worktree not found!", vim.log.levels.ERROR)
      return
    end

    worktree.setup({})

    -- Optional keybindings for common worktree commands
    local keymap_opts = { noremap = true, silent = true, desc = "Git Worktree" }

    -- Create a new worktree
    vim.keymap.set("n", "<leader>gwc", function()
      vim.ui.input({ prompt = "Worktree Name: " }, function(name)
        if name then
          worktree.create_worktree(name, "origin/main") -- Adjust branch as needed
        end
      end)
    end, keymap_opts)

    -- Switch to an existing worktree
    vim.keymap.set("n", "<leader>gws", function()
      vim.ui.input({ prompt = "Worktree Name to Switch: " }, function(name)
        if name then
          worktree.switch_worktree(name)
        end
      end)
    end, keymap_opts)

    -- Remove a worktree
    vim.keymap.set("n", "<leader>gwr", function()
      vim.ui.input({ prompt = "Worktree Name to Remove: " }, function(name)
        if name then
          worktree.remove_worktree(name)
        end
      end)
    end, keymap_opts)

    -- Load the git-worktree extension for Telescope
    telescope.load_extension("git_worktree")

    -- Keybindings for git worktree commands
    vim.keymap.set("n", "<leader>wt", function()
      telescope.extensions.git_worktree.git_worktrees()
    end, { noremap = true, silent = true, desc = "[W]orktree: Show worktrees" })

    vim.keymap.set("n", "<leader>wc", function()
      telescope.extensions.git_worktree.create_git_worktree()
    end, { noremap = true, silent = true, desc = "[W]orktree: Create new worktree" })
  end,
}
