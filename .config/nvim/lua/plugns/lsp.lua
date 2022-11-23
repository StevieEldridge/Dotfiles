-- Defines the base require path

local nvimLsp = require('lspconfig')

-- An array containing all LSP servers to be used
local servers = {
    'pyright',                  -- Python
    'fsautocomplete',           -- FSharp
    'csharp_ls',                -- CSharp
    'clangd',                   -- C/C++
    'bashls',                   -- Bash
    'remark_ls',                -- Markdown
    'vimls',                    -- Vimcode
    'tsserver',                 -- TypeScript
    'quick_lint_js',            -- JavaScript
    'vuels',                    -- Vue
    'html',                     -- HTML
    'cssls',                    -- CSS/LESS/SASS
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
-- Shows any issues on the current line
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<Leader>[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>]d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)

-- Special function that runs when a server attaches to a NeoVim buffer
-- Useful for global settings for each server such as keymaps
local onAttach = function(client, bufnr)
    -- Helper function for mapping keybindings
    local function bufSetKeymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Config options for each keybinding
    local bufopts = { noremap=true, silent=true }

    -- Jumps to declaration of a symbol (function, variable, etc)
    vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, bufopts)
    -- See some info about a symbol in a hover window
    vim.keymap.set('n', '<Leader>K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<Leader><C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
    -- Shows a list of references to a symbol
    vim.keymap.set('n', '<Leader>gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Links autocomplete up with the language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Sets up all LSP servers
-- Same as require('lspconfig').SERVER.setup {}
for _, lsp in ipairs(servers) do
    nvimLsp[lsp].setup {
        on_attach = onAttach
    }
end


-- Configuration for fsautocomplete
vim.cmd [[
    autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp
]]

-- Configuration for vscode-html-language-server
-- Enable (broadcasting) snippet capability for completion
local vscodeCapabilities = vim.lsp.protocol.make_client_capabilities()
vscodeCapabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = vscodeCapabilities,
}


-- Configuration for autocompletion using nvim-cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

-- better autocompletion experience
vim.o.completeopt = 'menuone,noselect'

cmp.setup {
	-- Format the autocomplete menu using lspkind-nvm
	formatting = {
		format = lspkind.cmp_format()
	},
	mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        -- Use Tab and shift-Tab to navigate autocomplete menu
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
        end,
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- Opens diagnostic window if the cursor is hovered over an error
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
