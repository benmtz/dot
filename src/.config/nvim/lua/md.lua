local M = {}

function M.fzf_headings(num)
  local buf = 0
  local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- Write to a temp file so preview always works (even if buffer isn't saved)
  local tmp = vim.fn.tempname() .. ".md"
  vim.fn.writefile(buf_lines, tmp)

  -- Collect H2 headings as: "lnum<TAB>text"
  local items = {}
  for i, line in ipairs(buf_lines) do
    local search_string = "^%s*" .. string.rep("#", num) .. "%s+"
    if line:match(search_string) then
      -- vim.print(line)
      table.insert(items, string.format("%d\t%s", i, line))
    end
  end

  local preview = table.concat({
    "sh -lc",
    vim.fn.shellescape(
      ("ln={1}; end=$((ln+80)); " ..
       "bat --style=numbers --color=always --language=markdown " ..
       "--line-range ${ln}:${end} %s 2>/tmp/fzf-preview.err || " ..
       "cat /tmp/fzf-preview.err")
      :format(vim.fn.shellescape(tmp))
    ),
  }, " ")


  require("fzf-lua").fzf_exec(items, {
    prompt = "H2> ",
    fzf_opts = {
      ["--delimiter"] = "\t",
      ["--with-nth"] = "2..",
      ["--preview-window"] = "right:60%:wrap",
      ["--preview"] = preview,
    },
    actions = {
      ["default"] = function(selected)
        local lnum = tonumber(selected[1]:match("^(%d+)\t"))
        if lnum then
          vim.api.nvim_win_set_cursor(0, { lnum, 0 })
          vim.cmd("normal! zz")
        end
      end,
    },
  })
end

function M.insert_note_line()
  local timestamp = os.date("[%Y-%m-%d %a %H:%M]")
  local line = "- " .. timestamp .. " "
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, { line })
  vim.api.nvim_win_set_cursor(0, { row + 1, #line })
  vim.cmd("startinsert!")
end

return M




