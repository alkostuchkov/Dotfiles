return {
    { 'rust-lang/rust.vim' }, -- Syntax and formatting
    {
        'mrcjkb/rustaceanvim',
        version = '^3',
        ft = { 'rust' },
        config = function()
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(_, bufnr)
                        -- Keymaps for Rust-specific LSP commands
                        vim.keymap.set('n', '<leader>ca', function()
                            vim.cmd.RustLsp('codeAction')
                        end, { buffer = bufnr, desc = 'Code Action' })
                        vim.keymap.set('n', '<leader>dr', function()
                            vim.cmd.RustLsp('debuggables')
                        end, { buffer = bufnr, desc = 'Debuggables' })
                    end,
                    default_settings = {
                        ['rust-analyzer'] = {
                            cargo = { allFeatures = true },
                            checkOnSave = true,
                            diagnostics = { enable = true },
                        },
                    },
                },
            }
        end,
    },
}
