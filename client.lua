function chatMessage(msg)
	TriggerEvent("chatMessage", "", {255, 255, 255}, msg)
end

RegisterNetEvent('ejectUser')
AddEventHandler('ejectUser', function(vehicle)
	local playerPed = PlayerPedId()
	TriggerEvent("chatMessage", "^4Bilgi: ", {255, 255, 255}, " ^1" .. " Araçtan atıldınız.")
	TaskLeaveAnyVehicle(playerPed, 0, 0)
	Wait(1500)
	SetPedToRagdoll(playerPed, 3000, 3000, 0, true, true, false)
end)

RegisterCommand("aractanat", function(source, args, raw)
	Citizen.CreateThread(function()
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)
	
	if GetVehiclePedIsIn(ped, false) == 0 then
		TriggerEvent('chatMessage', "^1Hata:", {255, 255, 255}, '^5Araçta değilken bu komutu kullanamazsınız!')
		return
	end
	
	if GetPedInVehicleSeat(vehicle, -1) ~= GetPlayerPed(-1) then
		TriggerEvent('chatMessage', "^1Hata:", {255, 255, 255}, '^5Sürücü olmadan bu komutu kullanamazsınız!')
		return
	end
	
	if args[1] == nil then
		TriggerEvent('chatMessage', "^1Hata:", {255, 255, 255}, '^5Bir yer belirtin!')
		TriggerEvent('chatMessage', "^1Örnek Kullanım:", {255, 255, 255}, '^4/aractanat [solarka/sagarka/sagon]!')
		return
	end
	
	if args[1] == 'sagon' then
		args[1] = 0
	elseif args[1] == 'solarka' then
		args[1] = 1
	elseif args[1] == 'sagarka' then
		args[1] = 2
	end
	
	local seat = tonumber(args[1])
	local pedSeat = GetPedInVehicleSeat(vehicle, tonumber(args[1]))

	if vehicle ~= 0 then
		if pedSeat == ped then
			TriggerEvent('chatMessage', "^1Hata:", {255, 255, 255}, '^5Kendinizi araçtan atamazsınız!')
			return
		end
		if pedSeat == 0 then
			TriggerEvent('chatMessage', "^1Hata:", {255, 255, 255}, '^5Koltukta kimse yok!')
			return
		end
	end
	
	TriggerServerEvent('ejectUser', GetPlayerServerId(NetworkGetEntityOwner(pedSeat)), vehicle)
	TriggerEvent("chatMessage", "^4Bilgi: ", {255, 255, 255}, " ^1" .. GetPlayerName(NetworkGetEntityOwner(pedSeat)) .. "'i araçtan attınız!")
	end)
end, false)