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
    bufSetKeymap('n', '<space>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    bufSetKeymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    bufSetKeymap('n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    bufSetKeymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    bufSetKeymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    bufSetKeymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    bufSetKeymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    bufSetKeymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    bufSetKeymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- Shows a list of references to a symbol
    bufSetKeymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Shows any issues on the current line
    bufSetKeymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    bufSetKeymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    bufSetKeymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    bufSetKeymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    bufSetKeymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

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
