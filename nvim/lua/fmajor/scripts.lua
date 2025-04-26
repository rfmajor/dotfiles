local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

vim.keymap.set('n', '<leader>t', function()
    local filetype = vim.bo.filetype
    local templates_dir = vim.fn.expand('$HOME/dotfiles/templates')
    local template_name = string.format("%s/template.%s", templates_dir, filetype)
    if file_exists(template_name) then
        vim.cmd(string.format(":r %s" ,template_name))
    end
end)

