local null_ls = require("null-ls")

null_ls.setup({
  sources = {
	-- below line doesn't work
  	--null_ls.builtins.formatting.ruff,
	-- below line causes <leader>f to be slower
	--null_ls.builtins.formatting.prettier,
  },
  on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
	  vim.keymap.set("n", "<Leader>f", function()
		vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
	  end, { buffer = bufnr, desc = "[lsp] format" })
	end

	if client.supports_method("textDocument/rangeFormatting") then
	  vim.keymap.set("x", "<Leader>f", function()
		vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
	  end, { buffer = bufnr, desc = "[lsp] format" })
	end
  end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "ts_ls", "eslint", "pylsp", "ruff", "clangd", "cmake", "rust_analyzer", "lua_ls" }
})

--TODO: lsp.on_attach, so that it works for all LSPs
local on_attach = function(client, bufnr)
	-- Enable LSP keybindings (example for go-to-definition)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_next, bufopts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<Leader>oi', function()vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = {vim.api.nvim_buf_get_name(0)}})end, bufopts)
	-- below line doesn't change anything
	--vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

require'lspconfig'.ts_ls.setup{
	on_attach = on_attach,
	capabilities = capabilities
}
require'lspconfig'.eslint.setup{}
require'lspconfig'.pylsp.setup{
	on_attach = on_attach,
	capabilities = capabilities
}
require'lspconfig'.ruff.setup{
	on_attach = on_attach,
	capabilities = capabilities
}
require'lspconfig'.clangd.setup{
	on_attach = on_attach,
	capabilities = capabilities
}
require'lspconfig'.cmake.setup{
	on_attach = on_attach,
	capabilities = capabilities
}
require'lspconfig'.rust_analyzer.setup{
	on_attach = on_attach,
	capabilities = capabilities
}
require'lspconfig'.lua_ls.setup{
	on_attach = on_attach,
	capabilities = capabilities
}
--require'lspconfig'.biome.setup{}

-- remove .vimrc remap of Enter for quickfix list
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'qf', -- 'qf' is the filetype for quickfix list
	callback = function()
		vim.keymap.set('n', '<CR>', '<CR>', { buffer = true }) -- Use default <CR> behavior
	end,
})

local prettier = require("prettier")

prettier.setup({
  bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
	"css",
	"graphql",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"less",
	"markdown",
	"scss",
	"typescript",
	"typescriptreact",
	"yaml",
  },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pcs', function()
	builtin.live_grep({
		additional_args = function(opts)
			return { "--case-sensitive" }
		end,
	})
end, {})

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
	vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
  end,
},
window = {
  -- completion = cmp.config.window.bordered(),
  -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<Up>'] = cmp.mapping.select_prev_item(),
  ['<Down>'] = cmp.mapping.select_next_item(),
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  -- ['<?>'] = cmp.mapping.complete(),
  -- ['<?>'] = cmp.mapping.close(),
  ['<Left>'] = cmp.mapping.abort(),
  ['<Right>'] = cmp.mapping.close(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' }, -- For vsnip users.
  -- { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}, {
  { name = 'buffer' },
})
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'git' },
}, {
  { name = 'buffer' },
})
})
require("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
-- mapping = cmp.mapping.preset.cmdline(),
-- sources = cmp.config.sources({
--   { name = 'path' }
-- }, {
--   { name = 'cmdline' }
-- }),
-- matching = { disallow_symbol_nonprefix_matching = false }
-- })

-- vim.keymap.set({ 'n', 'v' }, '<leader>gc', function()
-- 	builtin.git_bcommits_range({
-- 		from = vim.fn.getpos("'<")[2],
-- 		to = vim.fn.getpos("'>")[2]
-- 	})
-- end, {})

-- workaround for https://github.com/neovim/neovim/issues/21856
--vim.api.nvim_create_autocmd({ "VimLeave" }, {
--  callback = function()
--    vim.cmd('!notify-send  "hello"')
--    vim.cmd('sleep 10m')
--  end,
--})
--
--vim.api.nvim_create_autocmd({ "VimLeave" }, {
--  callback = function()
--    vim.fn.jobstart('notify-send "hello"', {detach=true})
--  end,
--})
