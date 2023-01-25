local keymap

keymap = {
  git_file_path             = "<leader>yg",
  edit_tasks                = "<leader>te",

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

}

return keymap
