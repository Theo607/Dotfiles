return {
	-- {
	-- 	"saghen/blink.cmp",
	-- 	dependencies = "rafamadriz/friendly-snippets",
	-- 	version = "*",
	-- 	opts = {
	-- 		keymap = { preset = "super-tab" },
	-- 		appearance = {
	-- 			use_nvim_cmp_as_default = true,
	-- 			nerd_font_variant = "mono",
	-- 		},
	-- 		sources = {
	-- 			default = { "lsp", "path", "snippets", "buffer" },
	-- 		},
	-- 		signature = { enabled = true },
	-- 	},
	-- 	opts_extend = { "sources.default" },
	-- },
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"clangd",
				"zls",
				"gopls",
				"bash-language-server",
				"pyright",
				"haskell-language-server",
				"vtsls",
				"tailwindcss-language-server",
				"tinymist",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)

			local mr = require("mason-registry")
			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc, silent = true })
					end

					map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
					map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
					map("n", "gr", function()
						require("telescope.builtin").lsp_references()
					end, "References (Telescope)")
					map("n", "cr", vim.lsp.buf.rename, "Rename Symbol")
					map({ "n", "v" }, "ca", vim.lsp.buf.code_action, "Code Action")

					map("n", "<leader>e", vim.diagnostic.open_float, "Line Diagnostics")
					map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
					map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
				end,
			})

			local servers = {
				"rust_analyzer",
				"clangd",
				"zls",
				"gopls",
				"bashls",
				"pyright",
				"hls",
				"vtsls",
				"tailwindcss",
				"tinymist",
			}

			for _, server in ipairs(servers) do
				local cfg = vim.lsp.config[server]
				if cfg then
					vim.lsp.config(server, cfg)
					vim.lsp.enable(server)
				end
			end
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format Document or Selection",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				bash = { "shfmt" },
			},
		},
	},
}
