-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
painel = {}
Tunnel.bindInterface("painel",painel)
vSERVER = Tunnel.getInterface("painel")

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(5000)
		ini()
	end
end)


RegisterCommand("painel", function()
	ini()
end)

function ini()
	toggle()
	enviaridnui()
	envui()
end

local open = false
function toggle()
	open = not open
	if open then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

idps = GetPlayerServerId(PlayerId())
function enviaridnui()
	local n1, n2 = vSERVER.envnome()
	SendNUIMessage({idcr = idps, nmes = n1.." "..n2 })
end

function envui()
	local n1, n2 = vSERVER.envnomes() 
	SendNUIMessage({ psids = vSERVER.envids(), psnomes = n1.." "..n2 })
end

RegisterNetEvent('pssnome')
AddEventHandler('pssnome', function(data)
    local pssnomes = data.nomepss
	SendNUIMessage({psnomes = pssnomes})
end)

RegisterNUICallback("front-to-back", function(data,cb)
	if data == "fechar" then toggle() end
end)

RegisterNUICallback("id", function(data,cb)
	TriggerServerEvent("id",data)
end)