local keymap

keymap = {
  switch_buffer_to_terminal = "<leader>zn",
  search_file_all           = "<leader>fh",
  search_file_git           = "<leader>ff",
  search_marks              = "<leader>fm",
  live_grep                 = "<leader>fg",
  telescope_project         = "<leader>fp",
  explorer                  = "<leader>fe",
  search_buffers            = "<leader>fb",
  search_run_tasks          = "<leader>fr",
  search_git_branches       = "<leader>gb",
  search_git_commits        = "<leader>gc",
  search_git_status         = "<leader>gs", -- ?
  git_file_path             = "<leader>yg",
  edit_tasks                = "<leader>te",

  -- term (z for zsh)
  term_buffer               = "<leader>ze",
  term_bottom               = "<leader>zx",
  term_right                = "<leader>zv",

  -- tabs
  tab_new                   = "<leader>te",
  tab_next                  = "<leader>tn",
  tab_previous              = "<leader>tp",

  -- ide capabilities
  code_format               = "<leader>cfm",
  code_references           = "<leader>cr",
  code_declaration          = "<leader>gD",
  code_definition           = "<leader>gd",
  code_implementation       = "<leader>gi",
  code_rename_symbol        = "<leader>rn",     -- refactor
  code_action               = "<leader>ca",     -- diagnostic fixes
  code_type_definition      = "<leader>D" ,     -- not sure how different it is from code_definition 
  code_signature_help       = "<leader><C-k>",  -- used method arity
  code_hover                = "<leader>K",      -- full method doc

  -- issues
  issue_show                = "<leader>is",
  issue_next                = "<leader>in",
  issue_previous            = "<leader>ip",
  issue_list                = "<leader>il",

  -- yank
  yank_path                 = "<leader>yp",
  yank_buffer               = "<leader>yb",
  yank_git                  = "<leader>yg",
}

return keymap
