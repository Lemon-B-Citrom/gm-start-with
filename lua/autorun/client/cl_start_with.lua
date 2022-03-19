--------------------------------------------------------------------------------
-- Const, globals, state, etc
--------------------------------------------------------------------------------
gStartWithConvar = "startwith_enabled"
gStartWithIsEnabled = CreateClientConVar(gStartWithConvar, "1", "Change whether players are given weapons from Start With"):GetBool()
local function conCommand(cvar, oldValue, newValue)
    gStartWithIsEnabled = tonumber(newValue) == 1
end
cvars.AddChangeCallback(gStartWithConvar, conCommand)

--------------------------------------------------------------------------------
-- Q Menu
--------------------------------------------------------------------------------
concommand.Add("startwith_query", function()
    if GetConVar("startwith_enabled"):GetBool() then
        Derma_Message("StartWith reports it is enabled")
    else
        Derma_Message("There's no one here :/")
    end
end)

local function ToolMenuPanel(panel)
    panel:SetName("Start With")
    panel:Help("foobar")
    panel:Button("baz", "startwith_query")
end

local function StartWithToolMenu()
    spawnmenu.AddToolMenuOption("Utilities", "Admin", "StartWithToolMenu", 
                                "Start With", "", "", ToolMenuPanel)
end
