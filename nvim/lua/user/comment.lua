local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup()

local status_ok2, ts_comment2 = pcall(require, "ts_context_commentstring")
if not status_ok then
	return
end

ts_comment2.setup({
	enable = true,
})
