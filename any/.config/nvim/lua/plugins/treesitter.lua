return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function ()
    require'nvim-treesitter'.install { 'lua', 'beancount', 'python', 'markdown', 'markdown_inline' }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lua', 'beancount', 'python', 'markdown', 'markdown_inline' },
      callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
