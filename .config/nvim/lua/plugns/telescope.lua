local telescope = require('telescope')

telescope.setup {}

-- Enables Fuzzy Search
-- Run after setup function
telescope.load_extension('fzf')
