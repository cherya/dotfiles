local dap = require('dap')
local utils = require('utils')

require('telescope').load_extension('dap')

utils.map('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>')
utils.map('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
utils.map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
utils.map('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
utils.map('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
utils.map('n', '<leader>dsbr',
          '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
utils.map('n', '<leader>dsbm',
          '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
utils.map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
utils.map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

-- dap-ui
utils.map('n', '<leader>dut', '<cmd>lua require"dapui".toggle()<cr>')

-- telescope-dap
utils.map('n', '<leader>dcc',
          '<cmd>lua require"telescope".extensions.dap.commands{}<cr>')
utils.map('n', '<leader>dco',
          '<cmd>lua require"telescope".extensions.dap.configurations{}<cr>')
utils.map('n', '<leader>dlb',
          '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<cr>')
utils.map('n', '<leader>dv',
          '<cmd>lua require"telescope".extensions.dap.variables{}<cr>')
-- utils.map('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<cr>')

dap.adapters.go = function(callback, config)
    local handle
    local pid_or_err
    local port = 38697
    handle, pid_or_err = vim.loop.spawn("dlv", {
        args = {"dap", "-l", "127.0.0.1:" .. port},
        detached = true
    }, function(code)
        handle:close()
        print("Delve exited with exit code: " .. code)
    end)
    -- Wait 100ms for delve to start
    vim.defer_fn(function()
        -- dap.repl.open()
        callback({type = "server", host = "127.0.0.1", port = port})
    end, 100)

    -- callback({type = "server", host = "127.0.0.1", port = port})
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {type = "go", name = "Debug", request = "launch", program = "${file}"}, {
        type = "go",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
    }, -- works with go.mod packages and sub packages 
    {
        type = "go",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    }
}
