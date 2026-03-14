-- https://github.com/nvim-java/nvim-java
return{
  'nvim-java/nvim-java',
  config = function()
    require('java').setup({
      jdk = {
        auto_install = false,
      },
    })
    vim.lsp.enable('jdtls')
  end,
}
