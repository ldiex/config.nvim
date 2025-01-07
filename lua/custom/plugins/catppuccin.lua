return {
  setup = function()
    -- Set up catppuccin
    vim.cmd [[colorscheme catppuccin]]

    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      background = { -- :h background_setting
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      term_colors = true, -- set terminal colors (works with `:terminal`)
      dim_inactive = {
        enabled = false, -- dims the background of inactive windows
        shade = 'dark',
        percentage = 0.05, -- percentage of the shade to apply to the inactive windows
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`)
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        indent_blankline = { enabled = true, shade = 'dark' },
        lsp_saga = false,
        which_key = true,
        neogit = true,
        dashboard = true,
        markdown = true,
        leap = { enabled = true, shade = 'dark' },
        bufferline = true,
        dap = { enabled = true, shade = 'dark' },
      },
    }
  end,
}
