local telescope = require('telescope')

telescope.load_extension "file_browser"
telescope.load_extension "project"

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
	},
	extensions = {
	  project = {
		  base_dirs = {
			  { path = "~/Code", max_depths = 1},
			},
			hidden_files = true, -- show hidden files
			on_project_selected_callback = function()
				return function()
				end
			end
		}
	}
}

