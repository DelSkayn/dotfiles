local blink = {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    build = 'cargo +nightly build --release',
    opts = {
        keymap = {
            preset = 'enter'
        }
    }
}


return { blink }
