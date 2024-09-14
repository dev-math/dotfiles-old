return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				registries = {
					"github:nvim-java/mason-registry",
					"github:mason-org/mason-registry",
				},
			},
		},
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettierd",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
			},
		})

		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = {
				"clangd",
				"tsserver",
				"html",
				"cssls",
				"jsonls",
				"jdtls",
				"rust_analyzer",
				"lua_ls",
			},
		})

		local skip_server_setup = {}
		local config = require("lsp_servers.default_config")

		mason_lspconfig.setup_handlers({
			-- default handler
			function(server_name)
				-- skip server
				for _, value in ipairs(skip_server_setup) do
					if value == server_name then
						return
					end
				end

				local ok, server_config = pcall(require, "lsp_servers." .. server_name)
				if ok then
					-- merge tables
					config = vim.tbl_deep_extend("force", config, server_config)
				end

				require("lspconfig")[server_name].setup(config)
			end,
		})
	end,
}
