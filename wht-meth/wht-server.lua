ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local webhook = "https://discord.com/api/webhooks/831161028783243294/VR1G3a6Irgm_kBILx07rNYSYoO444qj7YFKMMYVZ-LRGDuuo7dPSINQrW4F8xoaQjKjB"

RegisterServerEvent("wht:poset")
AddEventHandler("wht:poset", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getQuantity('plastic') >= 1 then
    xPlayer.removeInventoryItem("plastic", 1)
    xPlayer.addInventoryItem("wht_meth_poset", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()['wht_meth_poset'], "add",1)
    TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()['plastic'], "remove",1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Plastik Yok !')
    end
end)

RegisterServerEvent("wht:methham")
AddEventHandler("wht:methham", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('wht_meth_poset').count >= 1 then
    xPlayer.addInventoryItem("wht_meth_ham", 1)
    xPlayer.removeInventoryItem("wht_meth_poset", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()['wht_meth_ham'], "add",1)
    TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()['wht_meth_poset'], "remove",1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Poset Yok !')
    end
end)

RegisterServerEvent("wht:paketle")
AddEventHandler("wht:paketle", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('wht_meth_ham').count >= 1 then
    xPlayer.addInventoryItem("wht_meth", 1)
    xPlayer.removeInventoryItem("wht_meth_ham", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()['wht_meth'], "add",1)
    TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()['wht_meth_ham'], "remove",1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Meth Ham Yok !')
    end
end)

RegisterServerEvent("wht:sat")
AddEventHandler("wht:sat", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local para = math.random(450, 600)
    if xPlayer.getInventoryItem('wht_meth').count >= 1 then
    xPlayer.removeInventoryItem("wht_meth", para)
    xPlayer.addMoney(500)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Meth Yok !')
    end
end)

