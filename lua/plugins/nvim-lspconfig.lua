local on_attach = require("util.lsp").on_attach

local config = function()
	require("neoconf").setup({})

	-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
	require("cmp").setup({
		sources = {
			{ name = "nvim_lsp" },
		},
	})
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local lspconfig = require("lspconfig")
	-- Define custom signs
	local signs = { Error = "✗", Warn = "⚠", Hint = "➤", Info = "ℹ" }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- local capabilities = cmp_nvim_lsp.defautl_capabilities()

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- Custom settings for lua
			Lua = {
				-- Make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})
	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	lspconfig.ts_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

  lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettierd = require("efmls-configs.formatters.prettier_d")
  local stylelint = require("efmls-configs.linters.stylelint")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"typescript",
      "stylesheet"
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, black },
				typescript = { eslint_d, prettierd },
        stylesheet = { stylelint }
			},
		},
	})

	-- format on save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })
			if vim.tbl_isempty(efm) then
				return
			end
			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
}
