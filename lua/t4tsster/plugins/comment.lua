local setup, comment = pcall(require, "Comment")
if not setup then
    return
end

comment.setup({
    opleader = {
        ---Line-comment keymap
        line = 'gcv',
        ---Block-comment keymap
        block = 'gbv',
    },
})
