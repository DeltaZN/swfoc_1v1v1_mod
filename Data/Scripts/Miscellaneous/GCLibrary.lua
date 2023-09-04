-- Sleep() doesn't work for me :(
function wait(seconds)
    local t = GetCurrentTime.Frame()
    while t + seconds <= GetCurrentTime.Frame() do -- nothing
    end
end

function table_contains(tbl, x)
    found = false
    for _, v in pairs(tbl) do
        if v == x then
            found = true
            break
        end
    end
    return found
end

function Add_Unit(unit_type, player)
    Reinforce_Unit(Find_Object_Type(unit_type), false, player, true, true)
end

indigenous = {"HUTT_CIVILIAN", "IMPERIAL_ELITE_GUARD", "TWILEK_FEMALE", "SAND_PERSON_SNIPER_A", "SAND_PERSON_SNIPER_B",
              "JAWA_SCOUT", "WOOKIE_WARRIOR", "WOOKIE_WARRIOR_UNARMED", "EWOK_HUNTER", "CIVILIAN_INDEPENDENT_AI",
              "GUNGAN_WARRIOR", "DUST_DEVIL", "DESERT_SKETTO", "RANCOR", "WAMPA", "DATHOMIR_NIGHT_SISTER",
              "PYNGANI_WARRIOR", "GEONOSIAN", "IMPERIAL_GUARD_SPAWNER", "SULLUST_CAVE_COMPLEX_ENTRY",
              "JAWA_SANDCRAWLER", "WOOKIEE_HOUSE", "SANDPEOPLE_DWELLING", "VORNSKR_WOLF_INDIG", "PIRATE_GROUND_BASE_1"}

function Is_Indigenous(unit)
    local type_name = unit.Get_Type().Get_Name()
    return
        string.find(type_name, "_SPAWN") or string.find(type_name, "_CIV") or string.find(type_name, "_INDIGENOUS") or
            table_contains(indigenous, type_name)
end

function Change_Control_Indigenous(player)
    local player_unit_list = Find_All_Objects_Of_Type("Infantry | Structure")
    for k, unit in pairs(player_unit_list) do
        if Is_Indigenous(unit) then
            unit.Change_Owner(player)
        end
    end
end

function Spawn_Units(player)
    if StringCompare(Get_Game_Mode(), "Space") then
        Add_Unit("Z95_Headhunter_Squadron", player)
        Add_Unit("VWing_Squadron_P", player)
        Add_Unit("Pirate_Fighter_Squadron", player)
        Add_Unit("Merchant_Freighter", player)
        Add_Unit("Merchant_Freighter", player)
        if GameRandom.Get_Float() < 0.1 then
            Add_Objective("Our sensors have detected presense of a medium-size pirate fleet in the system!", false)
            Add_Unit("IPV1_System_Patrol_Craft", player)
            Add_Unit("IPV1_System_Patrol_Craft", player)
            Add_Unit("Pirate_Frigate", player)
            Add_Unit("Pirate_Frigate", player)
            Add_Unit("Jedi_Cruiser", player)
        end
        -- eastern egg
        if GameRandom.Get_Float() < 0.01 then
            Add_Unit("Death_Star", player)
        end
    else
        Add_Unit("Mandalorian_Indigenous_Company", player)
        Add_Unit("Noghri_Indigenous_Company", player)
        Add_Unit("Kashyyyk_Wookie_War_Party", player)
        Add_Unit("Sandpeople_War_Party", player)
        if GameRandom.Get_Float() < 0.25 then
            Add_Objective("We have reports of mandalorians who were hired to fight against us!", false)
            Add_Unit("Mandalorian_Indigenous_Company", player)
            Add_Unit("Mandalorian_Indigenous_Company", player)
            Add_Unit("Mandalorian_Indigenous_Company", player)
            Add_Unit("Mandalorian_Indigenous_Company", player)
            Add_Unit("Mandalorian_Indigenous_Company", player)
            Add_Unit("Mandalorian_Indigenous_Company", player)
        end
    end
end

function Apply_3rd_Player_Game_Mode(player)
    Add_Objective("It's possible that the third player is participating in the battle, be cautious!", false)
    FogOfWar.Reveal_All(player)
    Change_Control_Indigenous(player)
    Spawn_Units(player)
end

function Reveal_For_Player(player)
    local player_unit_list = Find_All_Objects_Of_Type(player)
    local has_valid_units = false
    for k, unit in pairs(player_unit_list) do
        if (unit.Is_Selectable()) then
            has_valid_units = true
            break
        end
    end
    if not has_valid_units then
        Apply_3rd_Player_Game_Mode(player)
    end
end

function Reveal_For_Specators()
    wait(15)
    Reveal_For_Player(Find_Player("Underworld"))
    Reveal_For_Player(Find_Player("Rebel"))
    Reveal_For_Player(Find_Player("Empire"))
end
