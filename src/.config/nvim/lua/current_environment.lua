local current_system =  {
  is_termux= os.getenv("TERMUX_VERSION") ~= ""
}

return current_system	
