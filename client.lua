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

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
            DrawTxt(x2, y2, 1.0,1.0,0.45, "~p~Discord: ~w~" .. display.ts, 255, 255, 255, 255)
            DrawTxt(x3, y3, 1.0,1.0,0.45, "~p~Area Of Roleplay: ~w~" .. aop, 255, 255, 255, 255)
            DrawTxt(0.660, 1.450, 1.0,1.0,0.45, "~p~Peacetime: ~w~" .. peacetimestatus, 255, 255, 255, 255)
    end
end)
