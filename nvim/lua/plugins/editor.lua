return {
	{
		"stevearc/oil.nvim",
		-- Do not lazy-load: oil must replace netrw for `nvim .` and `:e <dir>`.
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "-", "<cmd>Oil --float<cr>", desc = "Oil: open parent directory" },
			{ "<leader><space>", function() require("oil").toggle_float() end, desc = "Oil: toggle float" },
			{ "<F1>", function() require("oil").toggle_float() end, desc = "Oil: toggle float" },
			{ "<leader>E", function() require("oil").toggle_float(vim.fn.getcwd()) end, desc = "Oil: open cwd" },
		},
		config = function()
			local detail = false
			require("oil").setup({
				default_file_explorer = true,
				columns = { "icon" },
				win_options = {
					-- Two sign slots for oil-git-status (index + working tree).
					signcolumn = "yes:2",
					cursorline = true,
				},
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				prompt_save_on_select_new_entry = true,
				watch_for_changes = true,
				lsp_file_methods = {
					enabled = true,
					-- Save buffers that LSP rename edits touch (for example, updated imports).
					autosave_changes = "unmodified",
				},
				constrain_cursor = "name",
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name)
						return name == ".." or name == ".git" or name == ".DS_Store"
					end,
				},
				float = {
					padding = 2,
					max_width = 0.6,
					max_height = 0.8,
					border = "rounded",
					preview_split = "right",
					win_options = { winblend = 0 },
				},
				preview_win = {
					update_on_cursor_moved = true,
				},
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["l"] = "actions.select",
					["h"] = { "actions.parent", mode = "n" },
					["-"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
					["<C-v>"] = { "actions.select", opts = { vertical = true } },
					["<C-x>"] = { "actions.select", opts = { horizontal = true } },
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-p>"] = "actions.preview",
					["<C-r>"] = "actions.refresh",
					["q"] = { "actions.close", mode = "n" },
					["<Esc>"] = { "actions.close", mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
					["gy"] = { "actions.yank_entry", mode = "n" },
					["gd"] = {
						desc = "Toggle file detail view",
						callback = function()
							detail = not detail
							if detail then
								require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
							else
								require("oil").set_columns({ "icon" })
							end
						end,
					},
				},
				use_default_keymaps = false,
			})
		end,
	},
	{
		-- Git status signs in oil buffers (like the neo-tree git markers).
		"refractalize/oil-git-status.nvim",
		dependencies = { "stevearc/oil.nvim" },
		lazy = false,
		config = function()
			require("oil-git-status").setup({ show_ignored = true })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local filename = {
				"filename",
				file_status = true,
				path = 1,
				-- Show oil buffers as ~/path instead of oil:///full/path.
				fmt = function(str)
					if vim.bo.filetype ~= "oil" then
						return str
					end
					local dir = require("oil").get_current_dir()
					if not dir then
						return str
					end
					-- Rebuild rather than substitute: lualine may have shortened the path already.
					local name = vim.fn.fnamemodify(dir, ":~")
					if vim.bo.modified then
						return name .. " [+]"
					elseif not vim.bo.modifiable or vim.bo.readonly then
						return name .. " [-]"
					end
					return name
				end,
			}
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { filename },
					lualine_x = {
						{
							"diagnostics",
							sources = { "nvim_lsp" },
							symbols = { error = "", warn = "", info = "", hint = "" },
						},
						"encoding",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { filename },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				modes = {
					diagnostics = {
						auto_open = false,
						auto_close = true,
						auto_preview = true,
					},
				},
			})

			vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
			vim.keymap.set(
				"n",
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				{ desc = "Buffer Diagnostics (Trouble)" }
			)
			vim.keymap.set(
				"n",
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				{ desc = "Symbols (Trouble)" }
			)
			vim.keymap.set(
				"n",
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				{ desc = "LSP Definitions / references / ... (Trouble)" }
			)
			vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
			vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
		end,
	},
	"mbbill/undotree",
}
