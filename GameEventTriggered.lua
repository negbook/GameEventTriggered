local ThisIsUtilForLocalScript = true 

AddEventHandler('gameEventTriggered',function(name,args)
    GameEventTriggered(name,args)
end)

function GameEventTriggered(eventName, data)

    if eventName == "CEventNetworkEntityDamage" then
		local oldbuild = #data == 11
		local newbuild = #data == 13
		local i = 1
		local function iplus()
			local x = i 
			i = i + 1
			return x 
		end 
        victim = tonumber(data[iplus()])
        attacker = tonumber(data[iplus()])
		iplus()
		if newbuild then 
			iplus()
			iplus()
			if #data == 12 then i = i - 1 end 
		end 
        victimDied = tonumber(data[iplus()]) == 1 and true or false 
        weaponHash = tonumber(data[iplus()])
		iplus()
		iplus()
		iplus()
		iplus()
		iplus()
        isMeleeDamage = tonumber(data[iplus()]) ~= 0 and true or false 
        vehicleDamageTypeFlag = tonumber(data[iplus()]) 
		print(#data)
        local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(victim)
        local bonehash = -1 
        if FoundLastDamagedBone then
            bonehash = tonumber(LastDamagedBone)
        end
        
        local PPed = PlayerPedId()
        local distance = IsEntityAPed(attacker) and #(GetEntityCoords(attacker) - GetEntityCoords(victim)) or -1
        
        if victim == PPed then 
            if victimDied then
                local isplayer = IsPedAPlayer(attacker)
                
                local attackerid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)) or tostring(attacker==-1 and " " or attacker)
                
                local victimName = GetPlayerName(PlayerId())
                
                if IsEntityAPed(attacker)  then
                    
                    TriggerServerEvent('nbk_cstyle_killfeed:SyncPlayerDead',attackerid, weaponHash,isplayer,bonehash,distance)
                else
                    
                    TriggerServerEvent('nbk_cstyle_killfeed:SyncPlayerDead',attackerid, weaponHash,isplayer,bonehash,distance)
                end
            end 
            
        elseif  not IsPedAPlayer(victim) then 
            if victim and attacker then
                if victimDied then
                    if IsEntityAVehicle(victim) then
                        if not ThisIsUtilForLocalScript then 
                            TriggerEvent("OnVehicleDestroyed", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                        elseif OnVehicleDestroyed then 
                            OnVehicleDestroyed(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                        end 
                    else

                        if IsEntityAPed(victim) then
                            if IsEntityAVehicle(attacker) then
                                if not ThisIsUtilForLocalScript then 
                                    TriggerEvent("OnPedKilledByVehicle", victim, attacker, weaponHash,bonehash,distance)
                                elseif OnPedKilledByVehicle then  
                                    OnPedKilledByVehicle(victim, attacker, weaponHash,bonehash,distance)
                                end 
                                
                            elseif IsEntityAPed(attacker)  then
                                if IsPedAPlayer(attacker) then
                                    player = NetworkGetPlayerIndexFromPed(attacker);
                                    if not IsPedAPlayer(victim) then
                                       if not ThisIsUtilForLocalScript then 
                                            TriggerEvent("OnPedKilledByPlayer", victim, player, weaponHash, isMeleeDamage,bonehash,distance)
                                       elseif OnPedKilledByPlayer then   
                                            OnPedKilledByPlayer(victim, player, weaponHash, isMeleeDamage,bonehash,distance)
                                       end 
                                        
                                    end 
                                else
                                    if not IsPedAPlayer(victim) then
                                        if not ThisIsUtilForLocalScript then 
                                            TriggerEvent("OnPedKilledByPed",victim, attacker, weaponHash, isMeleeDamage,bonehash,distance)
                                        elseif OnPedKilledByPed then   
                                            OnPedKilledByPed(victim, attacker, weaponHash, isMeleeDamage,bonehash,distance)
                                        end 
                                    end
                                end
                            end
                            if not ThisIsUtilForLocalScript then 
                                TriggerEvent("OnPedDied", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                            elseif OnPedDied then     
                                OnPedDied(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                            end 
                        else
                            if not ThisIsUtilForLocalScript then 
                                TriggerEvent("OnEntityKilled", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                            elseif OnEntityKilled then     
                                OnEntityKilled(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                            end 
                        end
                    end
                else

                    if not IsEntityAVehicle(victim)  then
                        if not ThisIsUtilForLocalScript then 
                            TriggerEvent("OnEntityDamaged", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                        elseif OnEntityDamaged then  
                            OnEntityDamaged(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                        end 
                    else
                        if not ThisIsUtilForLocalScript then 
                            TriggerEvent("OnVehicleDamaged", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                        elseif OnVehicleDamaged then   
                            OnVehicleDamaged(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag,bonehash,distance)
                        end 
                    end
                end
            end
        end 
    end
end

