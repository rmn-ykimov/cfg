-- https://github.com/nvim-treesitter/nvim-treesitter (branch "main")
-- On "main" the plugin only installs parsers and queries; highlighting and
-- indentation are switched on per buffer with vim.treesitter.start().
local parsers = {
  "bash",
  "c",
  "c_sharp",
  "diff",
  "html",
  "java",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "nix",
  "properties",
  "python",
  "query",
  "rust",
  "sql",
  "toml",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "zig",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        -- Fails quietly for filetypes without an installed parser.
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
