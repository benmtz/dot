local telescope = require('telescope')

telescope.load_extension "go_task"
telescope.load_extension "file_browser"

telescope.setup {
	defaults = {
		path_display={"smart"} 
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			hidden = true
		},
		buffers = {
		  mappings = {
				i = {
				  ["<C-D>"] = "delete_buffer",
				}
			}
		}
	}
}

