AddEventHandler('onClientMapStart', function()
	TriggerServerEvent('yodaaop:sync_sv')
	TriggerServerEvent('yodapt:sync_sv')
end)

local aop = "Sandy Shores/Harmony/Grapeseed"

local cooldowntime = 0

local cooldown = "0"

local display = {

    ts = "discord",

}

Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped)
        local plate = GetVehicleNumberPlateText(veh)
        local rpm = math.ceil(GetVehicleCurrentRpm(veh) * 11) - 1
        local speed = math.ceil(GetEntitySpeed(veh) * 2.236936)
        local gear = GetVehicleCurrentGear(veh)
        if speed == 0 then
            gear = "N"
        elseif gear == 0 then
            gear = "~r~R"
        end
            DrawTxt(0.660, 1.425, 1.0,1.0,0.45,"~p~Plate: ~w~"..plate.."~p~ | MPH: ~w~"..speed.." ~p~| RPM: ~w~"..rpm.."X ~p~| Gear: ~w~"..gear, 255,255,255,255)
        end
    Citizen.Wait(1)
    end
end)

--[[ This part is WIP, 
Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
		local playername = GetPlayerName(source)
		local playerid = GetPlayerServerId(source)
		Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~p~ Name - ID: ~w~'..playerid..'~p~ | Name:  ~w~'..playername.."~p~ | AOP:  ~w~"..aop)
	end
end)]]

RegisterNetEvent('yodaaop:sync_cl')
AddEventHandler('yodaaop:sync_cl', function(exampleaop)
    aop = exampleaop
end)

function DrawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local x = 0
local y = 0
local x2 = 0
local y2 = 0
local x3 = 0
local y3 = 0

border_r = 255
border_g = 255
border_b = 255
border_a = 100

-- Use the following variables to adjust the color of the direction user is facing.
dir_r = 255
dir_g = 255
dir_b = 255
dir_a = 255

-- Use the following variables to adjust the color of the street user is currently on.
curr_street_r = 137
curr_street_g = 112
curr_street_b = 255
curr_street_a = 255

-- Use the following variables to adjust the color of the street around the player. (this will also change the town the user is in)
str_around_r = 255
str_around_g = 255 
str_around_b = 255
str_around_a = 255

-- Use the following variables to adjust the color of the city the player is in (without there being a street around them)
town_r = 255
town_g = 255
town_b = 255
town_a = 255

function drawTxt2(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
		local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]

		for k,v in pairs(directions)do
			direction = GetEntityHeading(GetPlayerPed(-1))
			if(math.abs(direction - k) < 22.5)then
				direction = v
				break;
			end
		end
		
		if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z))then
			if(zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1)))then
				if direction == 'N' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.306, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.285, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else 
						drawTxt2(x-0.285, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.285, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'NE' then 
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.298, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.277, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else 
						drawTxt2(x-0.277, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
					drawTxt2(x-0.277, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)),curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'E' then 
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.309, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.288, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else 
						drawTxt2(x-0.288, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
					drawTxt2(x-0.288, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'SE' then 
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.298, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.275, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else 
						drawTxt2(x-0.275, x+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.275, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'S' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.307, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.285, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else 
						drawTxt2(x-0.285, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.285, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'SW' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.292, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.270, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else 
						drawTxt2(x-0.270, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.270, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'W' then 
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.303, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then 
						drawTxt2(x-0.280, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.280, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.280, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'NW' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.290, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.266, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else 
						drawTxt2(x-0.266, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end 
						drawTxt2(x-0.266, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		 if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			x3 = 0.660 -- AOP
			y3 = 1.335 -- AOP
			x2 = 0.660 -- TEAMSPEAK
			y2 = 1.310 -- TEAMSPEAK
		 	x = 0.986 -- PLD This is the recommended cord if you use (Which I highly Recommended) - https://forum.fivem.net/t/release-street-label/43864
            y = 0.944 -- PLD This is the recommended cord if you use (Which I highly Recommended) - https://forum.fivem.net/t/release-street-label/43864
		 elseif not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			x3 = 0.660 -- AOP
			y3 = 1.360 -- AOP
			x2 = 0.660 -- TEAMSPEAK
			y2 = 1.335 -- TEAMSPEAK
			x = 0.986 -- PLD This is the recommended cord if you use (Which I highly Recommended) - https://forum.fivem.net/t/release-street-label/43864
			y = 0.971 -- PLD This is the recommended cord if you use (Which I highly Recommended) - https://forum.fivem.net/t/release-street-label/43864
		 end
	end
end)

local peacetimeon = false

peacetimestatus = "~r~Disabled"

RegisterNetEvent("yoda:peacetime")
AddEventHandler("yoda:peacetime", function(NewPeacetimestatus)
peacetimeon = NewPeacetimestatus
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if peacetimeon == false then
			peacetimestatus = "~r~Disabled"
		elseif peacetimeon == true then
			peacetimestatus = "~g~Enabled"
		end
	end
end)

local timeron = false
local second = 0
local minute = 0

RegisterNetEvent("yoda:cooldown_cl")
AddEventHandler("yoda:cooldown_cl", function(Something, Something2)
	minute = Something
	second = Something2
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
            DrawTxt(x2, y2, 1.0,1.0,0.45, "~p~Discord: ~w~" .. display.ts, 255, 255, 255, 255)
            DrawTxt(x3, y3, 1.0,1.0,0.45, "~p~Area Of Roleplay: ~w~" .. aop, 255, 255, 255, 255)
            DrawTxt(0.660, 1.450, 1.0,1.0,0.45, "~p~Peacetime: ~w~" .. peacetimestatus, 255, 255, 255, 255)
        if second < 10 and minute < 1 then
            DrawTxt(0.660, 1.250, 1.0,1.0,0.45, "~p~Priority Cooldown: ~w~(~p~0"..minute.."~w~:~p~0"..second.."~w~)", 255, 255, 255, 255)
        elseif second < 10 then
            DrawTxt(0.660, 1.250, 1.0,1.0,0.45, "~p~Priority Cooldown: ~w~(~p~"..minute.."~w~:~p~0"..second.."~w~)", 255, 255, 255, 255) 
        elseif minute < 1 then
            DrawTxt(0.660, 1.250, 1.0,1.0,0.45, "~p~Priority Cooldown: ~w~(~p~0"..minute.."~w~:~p~"..second.."~w~)", 255, 255, 255, 255) 
        else
		    DrawTxt(0.660, 1.250, 1.0,1.0,0.45, "~p~Priority Cooldown: ~w~(~p~"..minute.."~w~:~p~"..second.."~w~)", 255, 255, 255, 255)
        end
    end
end)
