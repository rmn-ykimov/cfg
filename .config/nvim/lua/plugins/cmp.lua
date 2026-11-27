-- Autocompletion: https://github.com/saghen/blink.cmp (docs: https://cmp.saghen.dev/)
return {
	"saghen/blink.cmp",
	-- v1 is the stable line; v2 is in development with breaking changes.
	-- A release tag also lets blink download its prebuilt Rust fuzzy matcher.
	version = "1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		-- Snippet engine
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			opts = {},
		},
		"folke/lazydev.nvim",
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			-- 'default': <C-y> accept, <C-n>/<C-p> select, <C-Space> open menu or docs,
			-- <C-e> hide, <C-b>/<C-f> scroll docs, <C-k> signature help.
			preset = "default",
			-- Move to the next / previous place in a snippet expansion
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			-- Same behaviour as before: the first item is selected, but nothing
			-- is inserted until <C-y>.
			list = { selection = { preselect = true, auto_insert = false } },
			-- <C-Space> shows the documentation of the selected item
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
		},

		sources = {
			default = { "lazydev", "lsp", "path", "snippets" },
			providers = {
				-- Neovim Lua API completions in the nvim config, ranked first
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},

		snippets = { preset = "luasnip" },

		-- Rust fuzzy matcher (prebuilt binary downloaded for the release tag);
		-- falls back to the Lua matcher with a warning if it cannot be loaded.
		fuzzy = { implementation = "prefer_rust_with_warning" },

		-- Parameter hints while typing function arguments
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
