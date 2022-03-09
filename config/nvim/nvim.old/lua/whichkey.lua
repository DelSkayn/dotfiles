return function ()
    vim.g.which_key_map = {
        ['l'] = {
            '+language',
            ['d'] = 'goto_definition'
        }
    }
end
