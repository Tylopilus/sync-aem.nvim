local M = {}

local function get_plugin_dir()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local repo_script_path = get_plugin_dir() .. "script/repo.sh"

local function run_command(cmd, args)
	local full_cmd = repo_script_path .. " " .. cmd .. ' -f "' .. args .. '"'
	local output = vim.fn.system(full_cmd)
	print(output)
end

function M.export_folder(path)
	path = path or vim.fn.expand("%:p:h")
	run_command("put", path)
	print("Exported folder to AEM: " .. path)
end

function M.import_folder(path)
	path = path or vim.fn.expand("%:p:h")
	run_command("get", path)
	print("Imported folder from AEM: " .. path)

	-- Refresh all buffers that are within the imported folder
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if vim.startswith(buf_name, path) then
			vim.cmd("checktime " .. buf)
		end
	end
end

function M.export_file()
	local current_file = vim.fn.expand("%:p")
	run_command("put", current_file)
	print("Exported current file to AEM: " .. current_file)
end

function M.import_file()
	local current_file = vim.fn.expand("%:p")
	run_command("get", current_file)
	print("Imported current file from AEM: " .. current_file)

	vim.cmd("edit!")
end

function M.setup()
	vim.cmd([[
        command! -nargs=? -complete=dir AEMExportFolder lua require('sync-aem').export_folder(<f-args>)
        command! -nargs=? -complete=dir AEMImportFolder lua require('sync-aem').import_folder(<f-args>)
        command! AEMExportFile lua require('sync-aem').export_file()
        command! AEMImportFile lua require('sync-aem').import_file()
    ]])
end

return M
