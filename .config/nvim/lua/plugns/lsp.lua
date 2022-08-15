-- Defines the base require path
local nvimLsp = require('lspconfig')

-- An array containing all LSP servers to be used
local servers = {
    'pyright',                  -- Python
    'fsautocomplete',           -- FSharp
    'csharp_ls',                -- CSharp
    'bashls',                   -- Bash
    'remark_ls',                -- Markdown
    'vimls',                    -- Vimcode
    'tsserver',                 -- TypeScript
    'quick_lint_js',            -- JavaScript
    'vuels',                    -- Vue
    'html',                     -- HTML
    'cssls',                    -- CSS/LESS/SASS
}

-- Special function that runs when a server attaches to a NeoVim buffer
-- Useful for global settings for each server such as keymaps
local onAttach = function(client, bufnr)
    -- Helper function for mapping keybindings
    local function bufSetKeymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Config options for each keybinding
    local opts = { noremap=true, silent=true }

    -- Jumps to declaration of a symbol (function, variable, etc)
    bufSetKeymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    bufSetKeymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- See some info about a symbol in a hover window
    bufSetKeymap('n', '<Leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    bufSetKeymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    bufSetKeymap('n', '<Leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    bufSetKeymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    bufSetKeymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    bufSetKeymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    bufSetKeymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    bufSetKeymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    bufSetKeymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- Shows a list of references to a symbol
    bufSetKeymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Shows any issues on the current line
    bufSetKeymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    bufSetKeymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    bufSetKeymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    bufSetKeymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    bufSetKeymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Links autocomplete up with the language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
