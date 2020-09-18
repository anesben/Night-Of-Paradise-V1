ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_joblisting:getJobsList', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM jobs2 WHERE whitelisted = @whitelisted', {
		['@whitelisted'] = false
	}, function(result)
		local data = {}

		for i=1, #result, 1 do
			table.insert(data, {
				job2   = result[i].name,
				label = result[i].label
			})
		end

		cb(data)
	end)
end)

RegisterServerEvent('esx_joblisting:setJob2')
AddEventHandler('esx_joblisting:setJob2', function(job2)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT whitelisted FROM jobs2 WHERE name = @name', {
		['@name'] = job2,
	}, function(result)
		if not result[1].whitelisted then
			xPlayer.setJob2(job2, 0)
		else
			print(('esx_joblisting: %s attempted to set a whitelisted job2! (lua injector)'):format(xPlayer.identifier))
		end
		
	end)

end)
