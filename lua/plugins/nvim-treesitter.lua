return
{
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  opts = {
	  ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'hlsl'},
		-- Autoinstall languages that are not installed
	  auto_install = true,
	  highlight = {
		  enable = true
	  }
  }
}
