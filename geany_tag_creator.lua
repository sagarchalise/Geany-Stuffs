--[[
  Sample script using the dialog module
--]]

-- Create the new dialog box
local dlg=dialog.new("Tag Creator", { "_Ok", "Cance_l" } )


dlg:file("path", "Select a Filetype of directory for generating tags/foldername will be used for tag name", "Paths:")
dlg:checkbox("use_dir", true, "Create from Directory")

local button, results = dlg:run()


-- Display the results
if ( button == 1 ) and results then
  local path=""
  if (results["use_dir"] == "1")then
    path=geany.basename(geany.dirname(results["path"]))
    cmd = string.format("geany -g %s.%s.tags $(find %s -name \*.%s)", path,path,path,path)
    --cmd = string.format("geany -g %s.%s.tags $(find %s -name \*.%s)", path
  end
  local msgbox=dialog.new("Results", {"OK"})
  msgbox:label("     ---  Results table  ---     ")
  msgbox:label(cmd)
  msgbox:run()
else
   local errbox=dialog.new("Cancelled", {"OK"})
   errbox:label("     Cancelled with button #"..button.."     ")
   errbox:run()
end
