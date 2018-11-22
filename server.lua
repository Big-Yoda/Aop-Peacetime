
local aop = "Sandy Shores/Harmony/Grapeseed"
local s = ""

RegisterCommand("aop", function(source, args, rawCommand)
if IsPlayerAceAllowed(source, "mgn-aop") then
    if args[1] ~= nil then
        aop = table.concat(args, " ")
        TriggerEvent("yodaaop:sync_sv")
        TriggerClientEvent("chatMessage", -1,"^*"..s.. "^1ANNOUNCEMENT: ^3RP has been moved to: ^7"..aop..".^3 Finish up your Current Roleplay and move there. Do not noclip or teleport or you might be kicked with/without warning!", {255, 255, 255})
	elseif args[1] == "" then
		TriggerEvent("yodaaop:sync_sv")
        TriggerClientEvent("chatMessage", -1,"^*"..s.. "^1ANNOUNCEMENT: ^3RP has been moved to: ^7Sandy Shores/Harmony/Grapeseed.^3 Finish up your Current Roleplay and move there. Do not noclip or teleport or you might be kicked with/without warning!", {255, 255, 255})
		aop = "Sandy Shores/Harmony/Grapeseed"
    end
else
    TriggerClientEvent("chatMessage", source, "^*^1Yoda AOP: ^3Insufficient Permission", {255, 255, 255})
end
end)

RegisterServerEvent("yodaaop:sync_sv")
AddEventHandler("yodaaop:sync_sv", function()
    TriggerClientEvent("yodaaop:sync_cl", -1, aop)
end)

RegisterServerEvent("yodapt:sync_sv")
AddEventHandler("yodapt:sync_sv", function()
    TriggerClientEvent("yoda:peacetime", -1, peacetimeon)
end)

peacetimeon = false

RegisterCommand("peacetime", function(source, args, raw)
if IsPlayerAceAllowed(source, "mgn-aop") then
	if peacetimeon == true then
		peacetimeon = false
		TriggerEvent("yodapt:sync_sv", peacetimeon)
	elseif peacetimeon == false then
		peacetimeon = true
		TriggerEvent("yodapt:sync_sv", peacetimeon)
	end
else
	TriggerClientEvent("chatMessage", source, "^*^1Yoda AOP: ^3Insufficient Permission", {255, 255, 255})
end
end)

RegisterCommand("cooldown", function(source, args, raw)
if IsPlayerAceAllowed(source, "mgn-aop") then
	local time = tonumber(args[1])
	if time == nil or time == "" then
		TriggerEvent("yoda:cooldown_sv", 15)
	elseif time > 30 then
		TriggerEvent("yoda:cooldown_sv", 30)
	else
		if timeron then
			TriggerClientEvent('chatMessage', source, "^1Cooldown", {255, 255, 255}, "^3The timer is already on.")
		else
			TriggerEvent("yoda:cooldown_sv", time)
		end
	end
else
	TriggerClientEvent("chatMessage", source, "^*^1Yoda AOP: ^3Insufficient Permission", {255, 255, 255})
end
end)

RegisterCommand("reset", function(source, args, raw)
if IsPlayerAceAllowed(source, "mgn-aop") then
	second = 0
	minute = 0
else
	TriggerClientEvent("chatMessage", source, "^*^1Yoda AOP: ^3Insufficient Permission", {255, 255, 255})
end
end)
	

RegisterServerEvent("yoda:cooldown_sv")
AddEventHandler("yoda:cooldown_sv", function(time)
	second = 0
	minute = time
	timeron = true
	TriggerClientEvent("yoda:cooldown_cl", -1, minute, second)
	TriggerClientEvent('chatMessage', -1, "^1^*ANNOUNCEMENT", {255, 255, 255}, "Priority Cooldown is now in effect for the next "..time.."Minute(s).")
	while timeron do
		Citizen.Wait(1000)
		if minute == 0 and second == 0 and timeron then
			timeron = false
			TriggerClientEvent('chatMessage', -1, "^1^*ANNOUNCEMENT", {255, 255, 255}, "Resume normal RP")
		elseif second == -1 then
			minute = minute - 1
			second = 59
		end
		TriggerClientEvent("yoda:cooldown_cl", -1, minute, second)
		second = second - 1
	end
end)
