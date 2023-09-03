--
-- Find all players by faction name. Work only in GC and not always. May be I have to add stealh unit which can't participate in battles like a smugller for all factions
--
-- @param faction    name of the faction (ie: Empire, Rebel, Underworld)
-- @return Set of players
-- 

-- function Find_All_Players(faction)
	-- local players = {}
	-- local faction_starting_unit = nil
	-- if faction == "Rebel" then
		-- faction_starting_unit = "Mon_Mothma"
	-- elseif faction == "Empire" then
		-- faction_starting_unit = "Emperor_Palpatine"
	-- elseif faction == "Underworld" then
		-- faction_starting_unit = "Tyber_Zann"
	-- end
	-- if faction_starting_unit ~= nil then
		-- for i, unit in pairs(Find_All_Objects_Of_Type(faction_starting_unit)) do
			-- addToSet(players, unit.Get_Owner())
		-- end
	-- end
	-- return players
-- end


-- Sleep() doesn't work for me :(
function wait(seconds) 
	local t = GetCurrentTime.Frame() 
	while t + seconds <= GetCurrentTime.Frame() do -- nothing
	end
end

function Reveal_For_Player(player)
	local player_unit_list = Find_All_Objects_Of_Type(player)
	local has_valid_units = false
	for k, unit in pairs(player_unit_list) do
		if (unit.Is_Selectable()) then
			has_valid_units = true
			break;
		end
	end
	if not has_valid_units then
		FogOfWar.Reveal_All(player)
	end
end

function Reveal_For_Specators()
	wait(12)
	Reveal_For_Player(Find_Player("Underworld"))
	Reveal_For_Player(Find_Player("Rebel"))
	Reveal_For_Player(Find_Player("Empire"))
end