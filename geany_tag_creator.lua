--[[
  Sample script using the dialog module
--]]

-- Create the new dialog box
local dlg=dialog.new("Tag Creator", { "_Ok", "Cance_l" } )


dlg:file("path", "Select a Filetype of directory for generating tags/foldername will be used for tag name", "Paths:")
dlg:checkbox("use_dir", true, "Create from Directory")
-- Create a drop-down list "proto" with default "http"
dlg:select("type", "Python",  "FileType for tag:")

-- Add some items to "proto" list...
dlg:option("type", "py",  "Python")
dlg:option("type", "php",  "PHP")
dlg:option("type", "js",  "JavaScript")
dlg:option("type", "lua",  "Lua")
dlg:option("type", "java",  "Java")

local button, results = dlg:run()


-- Display the results
if ( button == 1 ) and results then
  local path=""
  local filename=""
  local filetype=""
  local cmd=""
  local exec=""
  filetype=results["type"]
  if (results["use_dir"] == "1")then
    path=geany.dirname(results["path"])
    filename=geany.basename(path)
    else
    path=nil
    filename=string.reverse(string.sub(string.reverse(geany.basename(results["path"])), string.len(filetype)+2))
  end
  if(path)then
    cmd=string.format("geany -g ~/.config/geany/tags/%s.%s.tags $(find %s -name \*.%s)", filename,filetype,path,filetype)
  else
    cmd=string.format("geany -g ~/.config/geany/tags/%s.%s.tags %s)", filename,filetype,results["path"])
  end
  local msgbox=dialog.new("Results", {"OK"})
  exec=os.execute(cmd)
  msgbox:label(cmd.." executed")
  msgbox:label("Tags Created\nLoad it.")
  msgbox:run()
end