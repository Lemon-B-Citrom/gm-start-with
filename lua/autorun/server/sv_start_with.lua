--------------------------------------------------------------------------------
-- Const, globals, state, etc
--------------------------------------------------------------------------------
gStartWithConfigFile = "Start_With_config.json"
gStartWithSweps = {}
gStartWithConvar = "startwith_enabled"
gStartWithIsEnabled = true
--------------------------------------------------------------------------------
-- Initialization
--------------------------------------------------------------------------------
-- Fetch stored weapons
if file.Exists(gStartWithConfigFile, "DATA") then
    local localData = file.Read(gStartWithConfigFile, "DATA")
    gStartWithSweps = util.JSONToTable(localData)
-- Or write the empty table
else
    file.Write(gStartWithConfigFile, util.TableToJSON(gStartWithSweps))
end


--------------------------------------------------------------------------------
-- Retrieve the list of weapons to give from file
--------------------------------------------------------------------------------
local function FetchWeaponListFromFile()
    local localData = file.Read(gStartWithConfigFile, "DATA")
    gStartWithSweps = util.JSONToTable(localData)
end

--------------------------------------------------------------------------------
-- Save the list of weapons to give to file
--------------------------------------------------------------------------------
local function SaveWeaponListToFile()
    file.Write(gStartWithConfigFile, util.TableToJSON(gStartWithSweps))
end

--------------------------------------------------------------------------------
-- Add to the list of weapons to give
-- Expects a table
--------------------------------------------------------------------------------
local function AddToWeaponList(p_newWeapons)
    gStartWithSweps = table.Add(gStartWithSweps, p_newWeapons)
    file.Write(gStartWithConfigFile, util.TableToJSON(gStartWithSweps))
end

--------------------------------------------------------------------------------
-- Remove from the list of weapons to give
-- Expects a table
--------------------------------------------------------------------------------
local function RemoveFromWeaponList(p_toDelete)
    for _, weapon in ipairs(p_toDelete) do
        gStartWithSweps[weapon] = nil
    end
end

--------------------------------------------------------------------------------
-- Main function and hook
--------------------------------------------------------------------------------
local function GiveStartingSweps(player, isMapTransition)
    if not isMapTransition then
        for _, weapon in ipairs(gStartWithSweps) do
            player:Give(weapon)
        end
    end
end

-- Convar setup
gStartWithIsEnabled = CreateConVar(gStartWithConvar, 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, 
        "Change whether players are given weapons from Start With"):GetBool()
local function conCommand(cvar, oldValue, newValue)
    gStartWithIsEnabled = tonumber(newValue) == 1
    if gStartWithIsEnabled then
        hook.Add("PlayerSpawn", "StartWith.StartingSweps", GiveStartingSweps)
    else
        hook.Remove("PlayerSpawn", "StartWith.StartingSweps")
    end
end
cvars.AddChangeCallback(gStartWithConvar, conCommand)
-- Hook according to the convar
if gStartWithIsEnabled then
    hook.Add("PlayerSpawn", "StartWith.StartingSweps", GiveStartingSweps)
else
    hook.Remove("PlayerSpawn", "StartWith.StartingSweps")
end


