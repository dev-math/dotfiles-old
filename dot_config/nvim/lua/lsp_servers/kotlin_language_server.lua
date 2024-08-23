local M = {}

M.root_dir = function(fname)
	local util = require("lspconfig").util
	return util.root_pattern(".git")(fname)
		or util.root_pattern("pom.xml")(fname)
		or util.root_pattern("build.xml")(fname)
		or util.root_pattern("settings.gradle.kts")(fname)
		or util.root_pattern("settings.graddle")(fname)
end

M.autostart = true

M.single_file_support = true

M.init_options = {
	provideFormatter = true,
	-- embeddedLanguages = { css = true, javascript = true },
	-- configurationSection = { "html", "css", "javascript" },
}

local bin_name = 'kotlin-language-server'
if vim.fn.has 'win32' == 1 then
  bin_name = bin_name .. '.bat'
end

M.cmd = { bin_name }

return M
