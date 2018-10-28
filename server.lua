print("AOP Script By Big Yoda")
print("Feel Free to Edit and and reupload just credit Big Yoda or LaLord on the Fivem Community Website")

local aop = "Sandy Shores/Harmony/Grapeseed"
local s = ""

RegisterCommand("aop", function(source, args, rawCommand)
if IsPlayerAceAllowed(source, "yoda-aop") then
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

peacetimeon = false

RegisterCommand("peacetime", function(source, args, raw)
if IsPlayerAceAllowed(source, "yoda-aop") then
	if peacetimeon == true then
		peacetimeon = false
		TriggerClientEvent("yoda:peacetime", -1, peacetimeon)
	elseif peacetimeon == false then
		peacetimeon = true
		TriggerClientEvent("yoda:peacetime", -1, peacetimeon)
	end
else
	TriggerClientEvent("chatMessage", source, "^*^1Yoda AOP: ^3Insufficient Permission", {255, 255, 255})
end
end)
