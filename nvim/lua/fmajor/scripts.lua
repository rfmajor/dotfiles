vim.keymap.set({ "n", "v" }, "<leader>f", function()
    local mode = vim.fn.mode()

    local opts = {
        async = true,
        lsp_fallback = true,
    }

    -- If in visual mode, calculate selected range
    if mode == "v" or mode == "V" or mode == "\22" then
        local start_pos = vim.api.nvim_buf_get_mark(0, "<") -- start of selection
        local end_pos = vim.api.nvim_buf_get_mark(0, ">")   -- end of selection

        opts.range = {
            start = { start_pos[1], start_pos[2] },
            ["end"] = { end_pos[1], end_pos[2] },
        }
    end

    require("conform").format(opts)
end, { desc = "Format selection or whole file" })

function Dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. Dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

