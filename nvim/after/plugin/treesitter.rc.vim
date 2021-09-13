if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF
require('nvim-treesitter.configs').setup {
    highlight = {enable = true, disable = {}},
    indent = {enable = false, disable = {}},
    ensure_installed = {
        "tsx", "javascript", "go", "python", "toml", "json", "yaml", "html",
        "scss", "css", "bash"
    },
    rainbow = {enable = true}
}

local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = {"javascript", "typescript.tsx"}
EOF