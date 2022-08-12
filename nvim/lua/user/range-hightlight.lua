local status_ok, range_highlight = pcall(require, "range-highlight")
if not status_ok then
  return
end

range_highlight.setup()
