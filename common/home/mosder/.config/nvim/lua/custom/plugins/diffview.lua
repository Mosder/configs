-- View git commit diffs

vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

local diffview = require 'diffview'
local actions = require 'diffview.actions'

diffview.setup {
  keymaps = {
    file_panel = {
      { 'n', 's', actions.toggle_stage_entry, { desc = '[S]tage file under cursor' } },
      { 'n', 'j', actions.select_next_entry, { desc = 'Go to next file entry' } },
      { 'n', 'k', actions.select_prev_entry, { desc = 'Go to previous file entry' } },
      { 'n', 'q', diffview.close, { desc = '[Q]uit view' } },
    },
    file_history_panel = {
      { 'n', 's', actions.open_in_diffview, { desc = '[S]elect commit for diffview' } },
      { 'n', 'q', diffview.close, { desc = '[Q]uit view' } },
    },
  },
}

-- keymaps
vim.keymap.set('n', '<leader>dc', diffview.open, { desc = '[D]iff [C]urrent' })
vim.keymap.set('n', '<leader>dh', diffview.file_history, { desc = '[D]iff [H]istory' })
vim.keymap.set('n', '<leader>dq', diffview.close, { desc = '[D]iff [Q]uit' })
vim.keymap.set('n', '<leader>db', function() diffview.open { 'origin/HEAD...HEAD' } end, { desc = '[D]iff [B]ranch' })
