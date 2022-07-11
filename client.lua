local open = false

local open = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Wait(0)
	end
end)

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end


-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)



RegisterCommand("lihatid", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end, false)

RegisterCommand("tunjukanid", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)
    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then

      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
      playAnim('mp_common', 'givetake1_a', 2500)
      Wait(250)
        local lihatktp = "Menunjukan KTP"
        local text = lihatktp
        TriggerServerEvent('3dme:shareDisplay', text)
    else
      ESX.ShowNotification('Tidak Ada Player Di Dekatmu')
    end
end, false)

RegisterCommand("lihatsim", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0) 

    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
end, false)

RegisterCommand("tunjukansim", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
      playAnim('mp_common', 'givetake1_a', 2500)
      Wait(250)
      local lihatsim = "Menunjukan SIM"
      local text = lihatsim
      TriggerServerEvent('3dme:shareDisplay', text)
    else
      ESX.ShowNotification('Tidak Ada Player Di Dekatmu')
    end
end, false)

RegisterCommand("lihatlisensi", function(source, args, rawCommand)
  -- Wait for next frame just to be safe
  Citizen.Wait(0)

  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
end, false)

RegisterCommand("tunjukanlsenjata", function(source, args, rawCommand)
  -- Wait for next frame just to be safe
  Citizen.Wait(0)
  local player, distance = ESX.Game.GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
    playAnim('mp_common', 'givetake1_a', 2500)
    Wait(250)
    local lihatlsenjata = "Menunjukan Lisensi Senjata"
    local text = lihatlsenjata
    TriggerServerEvent('3dme:shareDisplay', text)
  else
    ESX.ShowNotification('No players nearby')
  end
end, false)

RegisterCommand("karungin", function(source, args, raw) --change command here

  lagiblindfold = true

  local lib = 'random@mugging4'

  local anim = 'struggle_loop_b_thief'

  ESX.Streaming.RequestAnimDict(lib, function()

      TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, false, false, false)

  end)

  

  Citizen.Wait(3000)



  local player, distance = ESX.Game.GetClosestPlayer()



  if distance ~= -1 and distance <= 2.0 then

    ESX.TriggerServerCallback('jsfour-blindfold:itemCheck', function( hasItem )

      TriggerServerEvent('jsfour-blindfold', GetPlayerServerId(player), hasItem)

    end)

  end



  lagiblindfold = false

end, false)

RegisterCommand("lepaskarung", function()

	TriggerEvent('skinchanger:getSkin', function(skin)

		local clothesSkin = {

			['mask_1'] = 0, ['mask_2'] = 0

		}

		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

	end)

  	SendNUIMessage({

		action = "close"

	})

end)

RegisterCommand("frontleft", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        if GetVehicleDoorAngleRatio(veh, 0) > 0 then
            SetVehicleDoorShut(veh, 0, false)
        else
            SetVehicleDoorOpen(veh, 0, false, false)
        end
    end
end, false)



RegisterCommand("frontright", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        if GetVehicleDoorAngleRatio(veh, 1) > 0 then
            SetVehicleDoorShut(veh, 1, false)
        else
            SetVehicleDoorOpen(veh, 1, false, false)
        end
    end
end, false)

RegisterCommand("backleft", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        if GetVehicleDoorAngleRatio(veh, 2) > 0 then
            SetVehicleDoorShut(veh, 2, false)
        else
            SetVehicleDoorOpen(veh, 2, false, false)
        end
    end
end, false)

RegisterCommand("backright", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        if GetVehicleDoorAngleRatio(veh, 3) > 0 then
            SetVehicleDoorShut(veh, 3, false)
        else
            SetVehicleDoorOpen(veh, 3, false, false)
        end
    end
end, false)