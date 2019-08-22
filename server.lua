RegisterServerEvent('ejectUser')
AddEventHandler('ejectUser', function(target, vehicle)
	TriggerClientEvent('ejectUser', target, vehicle)
end)