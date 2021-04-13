ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Ped Ekleme Blip Ekleme

Citizen.CreateThread(function()
	for k,v in pairs(Config.Pedler) do
		RequestModel(v.model)
		while not HasModelLoaded(v.model) do Citizen.Wait(1) end
		v.handle = CreatePed(4, v.model, v.coords.x, v.coords.y, v.coords.z-1.0, v.heading, false, false)
		GiveWeaponToPed(v.handle, v.weapon, 10, 1, 1)
		SetPedFleeAttributes(v.handle, 0, 0)
		SetPedDropsWeaponsWhenDead(v.handle, false)
		SetPedDiesWhenInjured(v.handle, false)
		SetEntityInvincible(v.handle , true)
		FreezeEntityPosition(v.handle, true)
		SetBlockingOfNonTemporaryEvents(v.handle, true)
		if v.anim.type == 1 then
			TaskStartScenarioInPlace(v.handle, v.anim.name, 0, true)
		elseif v.anim.type == 2 then
			RequestAnimDict(v.anim.dict)
			while not HasAnimDictLoaded(v.anim.dict) do Citizen.Wait(1) end
			TaskPlayAnim(v.handle, v.anim.dict, v.anim.name, 8.0, 1, -1, 49, 0, false, false, false)
		end
	end
end)

function ihbar()
    local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)
    TriggerServerEvent('esx_phone:send', 'police', ('Torbaci Vakasi !'), false, {
		x = coords.x,
		y = coords.y,
		z = coords.z
	})
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Blips) do
		local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
		SetBlipSprite(blip, v.id)
		SetBlipColour(blip, v.color)
		--SetBlipDisplay(blip, 1)
		SetBlipScale(blip, 0.9)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
    	AddTextComponentString(v.title)
    	EndTextCommandSetBlipName(blip)
	end
end)

function SatisBlipOlustur(x,y,z)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip, 1)
	SetBlipColour(blip, 4)
	AddTextEntry('MYBLIP', "Alıcı")
	BeginTextCommandSetBlipName('MYBLIP')
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
	return blip
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        if satiyormu == false and satisblip ~= false then
            sleep = 7
			RemoveBlip(satisblip)
			satisblip = false
        end
        Citizen.Wait(sleep)
    end

    local coords = vector3(Config.PedKonum.x, Config.PedKonum.y, Config.PedKonum.z)
    local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 500)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 1)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Uyuşturucu Satıcısı')
    EndTextCommandSetBlipName(blip)
end)


Citizen.CreateThread(function()
    while true do
        local sleep = 5000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.MethCikis.x, Config.MethCikis.y, Config.MethCikis.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.MethGiris.x, Config.MethGiris.y, Config.MethGiris.z, true)
        if dst < 4 then
            sleep = 4
            DrawMarker(2, Config.MethCikis.x, Config.MethCikis.y, Config.MethCikis.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.1, 0.1, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst < 5 then
                DrawText3D(Config.MethCikis.x, Config.MethCikis.y, Config.MethCikis.z + 0.2, '[E] Disari Cik !')
                if IsControlJustReleased(0, 38) then
                    menuac()
                    --SetEntityCoords(player, Config.MethGiris.x, Config.MethGiris.y, Config.MethGiris.z, false, false, false, true)
                end
            end
        end
        if dst2 < 4 then
            sleep = 5
            DrawMarker(2, Config.MethGiris.x, Config.MethGiris.y, Config.MethGiris.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 5 then
                DrawText3D(Config.MethGiris.x, Config.MethGiris.y, Config.MethGiris.z + 0.2, '[E] Iceri Gir')
                if IsControlJustReleased(0, 38) then
                    menuac() 
                 --   SetEntityCoords(player, Config.MethCikis.x, Config.MethCikis.y, Config.MethCikis.z, false, false, false, true)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 5000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.OzelPoset.x, Config.OzelPoset.y, Config.OzelPoset.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.OzelPoset.x, Config.OzelPoset.y, Config.OzelPoset.z, true)
if dst2 < 4 then
    sleep = 5
    DrawMarker(2, Config.OzelPoset.x, Config.OzelPoset.y, Config.OzelPoset.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
    if dst2 < 4 then
        DrawText3D(Config.OzelPoset.x, Config.OzelPoset.y, Config.OzelPoset.z + 0.2, '[E] Poset Uret')
        if IsControlJustReleased(0, 38) then
            FreezeEntityPosition(PlayerPedId(), true)
          --  exports["hsn-bar"]:taskBar(3000, "Poset Uretiyorsun")
          SetEntityHeading(PlayerPedId(), 157.13)
          TriggerEvent("mythic_progbar:client:progress", {
            name = "wht-meth",
            duration = 5000,
            label = "Poset Uretiyorsun ...",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
            },
            prop = {
                model = "",
            }
        }, function(status)
            if not status then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerServerEvent("wht:poset", source)
                ClearPedTasks(PlayerPedId())
            end
        end)
           FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end
Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 5000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.Kutulama.x, Config.Kutulama.y, Config.Kutulama.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.Kutulama.x, Config.Kutulama.y, Config.Kutulama.z, true)
if dst2 < 4 then
    sleep = 5
    DrawMarker(2, Config.Kutulama.x, Config.Kutulama.y, Config.Kutulama.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
    if dst2 < 4 then
        DrawText3D(Config.Kutulama.x, Config.Kutulama.y, Config.Kutulama.z + 0.2, '[E] Methi Kutula')
        if IsControlJustReleased(0, 38) then
            FreezeEntityPosition(PlayerPedId(), true)
          --  exports["hsn-bar"]:taskBar(3000, "Poset Uretiyorsun")
        SetEntityHeading(PlayerPedId(), 190.35)
        TriggerEvent("mythic_progbar:client:progress", {
            name = "wht-meth",
            duration = 5000,
            label = "Meth Topluyup Posete Dolduruyorsun ...",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
            },
            prop = {
                model = "",
            }
        }, function(status)
            if not status then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerServerEvent("wht:methham", source)
                ClearPedTasks(PlayerPedId())
            end
        end)
           FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end
Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 5000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.Paketle.x, Config.Paketle.y, Config.Paketle.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.Paketle.x, Config.Paketle.y, Config.Paketle.z, true)
if dst2 < 4 then
    sleep = 5
    DrawMarker(2, Config.Paketle.x, Config.Paketle.y, Config.Paketle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
    if dst2 < 4 then
        DrawText3D(Config.Paketle.x, Config.Paketle.y, Config.Paketle.z + 0.2, '[E] Meth Paketle')
        if IsControlJustReleased(0, 38) then
            FreezeEntityPosition(PlayerPedId(), true)
          TriggerEvent("mythic_progbar:client:progress", {
            name = "wht-meth",
            duration = 5000,
            label = "Meth Paketliyorsun ...",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "creatures@rottweiler@tricks@",
                anim = "petting_franklin",
            },
            prop = {
                model = "",
            }
        }, function(status)
            if not status then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerServerEvent("wht:paketle", source)
                ClearPedTasks(PlayerPedId())
            end
        end)
           FreezeEntityPosition(PlayerPedId(), false)
         --   SetEntityCoords(player, Config.MethCikis.x, Config.MethCikis.y, Config.MethCikis.z, false, false, false, true)
        end
    end
end
Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 5000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.Alici.x, Config.Alici.y, Config.Alici.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.Alici.x, Config.Alici.y, Config.Alici.z, true)
if dst2 < 4 then
    sleep = 5
    DrawMarker(2, Config.Alici.x, Config.Alici.y, Config.Alici.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
    if dst2 < 4 then
        DrawText3D(Config.Alici.x, Config.Alici.y, Config.Alici.z + 0.2, '[E] Methi Sat')
        if IsControlJustReleased(0, 38) then
            FreezeEntityPosition(PlayerPedId(), true)
          TriggerEvent("mythic_progbar:client:progress", {
            name = "wht-meth",
            duration = 5000,
            label = "Meth Satis Menusunu Aciyorsun ...",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@triathlon",
                anim = "want_some_of_this",
            },
            prop = {
                model = "",
            }
        }, function(status)
            if not status then
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                alicimenu()
                ihbar()
            end
        end)
           FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end
Citizen.Wait(sleep)
end
end)

-- Menuler

alicimenu = function ()
    ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'wht-meth',
            {
                title    = 'Satış Menüsü',
                align    = 'top-right',
                elements = {
                    {label = "Meth", value = "meth"},
                }
            },
            function(data, menu)
                if data.current.value == "meth" then
             TriggerServerEvent("wht:sat", source)
                    -- TriggerServerEvent('wht:selling', "meth", "5000")
                end
            end,
            function(data, menu)
                menu.close()
		textstatus = true
            end
        )
end

menuac = function()
    elements = {
        {label = 'laboratuvara Gir !',value = 'gir'},
        {label = 'Disari Cik !',value = 'cik'},
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meth', {
        title    = "Giris / Cikis",
        align    = 'top-right',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'gir' then
            SetEntityCoords(PlayerPedId(), Config.MethCikis.x, Config.MethCikis.y, Config.MethCikis.z, false, false, false, true)        
            menu.close()
        end
            if data.current.value == 'cik' then
                SetEntityCoords(PlayerPedId(), Config.MethGiris.x, Config.MethGiris.y, Config.MethGiris.z, false, false, false, true)
                menu.close()
    end
    end)
end

DrawText3D = function (x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 41, 11, 41, 68)
    ClearDrawOrigin()
end

-- Bilgi Kismi

