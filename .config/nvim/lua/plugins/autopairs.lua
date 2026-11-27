-- autopairs
-- https://github.com/windwp/nvim-autopairs
-- Brackets after an accepted function completion come from blink.cmp
-- (completion.accept.auto_brackets), so no completion hook is needed here.

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {},
}
