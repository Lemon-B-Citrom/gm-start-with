local startWithSweps = {"weapon_hands", "weapon_bsmod_punch", "weapon_physcannon"}

local function GiveStartingSweps(player, isMapTransition)
    if not isMapTransition then
        for _, weapon in ipairs(startWithSweps) do
            player:Give(weapon)
        end
    end
end

hook.Add("PlayerSpawn", "StartWith.StartingSweps", GiveStartingSweps)
