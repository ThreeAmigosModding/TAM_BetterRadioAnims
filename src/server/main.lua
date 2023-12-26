local scully = lib.checkDependency("scully_emotemenu", "1.8.0")
local rpemotes = lib.checkDependency("rpemotes", "1.3.8")

if scully and not rpemotes then 
    lib.print.info("Successfully loaded scully_emotemenu integration!")
elseif not scully and rpemotes then
    lib.print.info("Successfully loaded rpemotes integration!")
else
    lib.print.error('rpemotes or scully_emotemenu is either outdated or missing or both installed. Please update and make sure you only have one of the resources installed and running.')
end