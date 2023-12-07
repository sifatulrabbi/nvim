local ibl_highlight = {
    'CursorColumn',
    'Whitespace',
}
require('ibl').setup({
    indent = {
        highlight = ibl_highlight,
        char = '',
    },
    whitespace = {
        highlight = ibl_highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
})
