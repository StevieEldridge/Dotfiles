local telescope = require('telescope')

telescope.setup {}

-- Run after setup function
telescope.load_extension('fzf')  -- Enables Fuzzy Search
telescope.load_extension('projects')  -- Enables Project Search
