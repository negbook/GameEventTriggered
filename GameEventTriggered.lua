local ThisIsUtilForLocalScript = true 

AddEventHandler('gameEventTriggered',function(name,args)
    GameEventTriggered(name,args)
end)

function GameEventTriggered(eventName, data)

    if eventName == "CEventNetworkEntityDamage" then
        victim = tonumber(data[1])
        attacker = tonumber(data[2])
        victimDied = tonumber(data[4]) == 1 and true or false 
        weaponHash = tonumber(data[5])
        isMeleeDamage = tonumber(data[10]) ~= 0 and true or false 
        vehicleDamageTypeFlag = tonumber(data[11]) 
        local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(victim)
        local bonehash = nil 
        if FoundLastDamagedBone then
            bonehash = tonumber(LastDamagedBone)
        end
        if victim and attacker then
            if victimDied then
                if IsEntityAVehicle(victim) then
                    if not ThisIsUtilForLocalScript then 
                        TriggerEvent("OnVehicleDestroyed", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                    elseif OnVehicleDestroyed then 
                        OnVehicleDestroyed(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                    end 
                else

                    if IsEntityAPed(victim) then
                        if IsEntityAVehicle(attacker) then
                            if not ThisIsUtilForLocalScript then 
                                TriggerEvent("OnPedKilledByVehicle", victim, attacker, weaponHash)
                            elseif OnPedKilledByVehicle then  
                                OnPedKilledByVehicle(victim, attacker, weaponHash)
                            end 
                            
                        elseif IsEntityAPed(attacker)  then
                            if IsPedAPlayer(attacker) then
                                player = NetworkGetPlayerIndexFromPed(attacker);
                                if IsPedAPlayer(victim) then
                                    if not ThisIsUtilForLocalScript then 
                                        TriggerEvent("OnPlayerKilledByPlayer", NetworkGetPlayerIndexFromPed(victim), NetworkGetPlayerIndexFromPed(attacker), weaponHash, isMeleeDamage)
                                    elseif OnPlayerKilledByPlayer then   
                                        OnPlayerKilledByPlayer(NetworkGetPlayerIndexFromPed(victim), NetworkGetPlayerIndexFromPed(attacker), weaponHash, isMeleeDamage)
                                    end 
                                else 
                                    if not ThisIsUtilForLocalScript then 
                                        TriggerEvent("OnPedKilledByPlayer", victim, player, weaponHash, isMeleeDamage)
                                    elseif OnPedKilledByPlayer then   
                                        OnPedKilledByPlayer(victim, player, weaponHash, isMeleeDamage)
                                    end 
                                    
                                end 
                            else
                                if IsPedAPlayer(victim) then
                                    if not ThisIsUtilForLocalScript then 
                                    TriggerEvent("OnPlayerKilledByPed", NetworkGetPlayerIndexFromPed(victim), attacker, weaponHash, isMeleeDamage)
                                    elseif OnPlayerKilledByPed then    
                                    OnPlayerKilledByPed(NetworkGetPlayerIndexFromPed(victim), attacker, weaponHash, isMeleeDamage)
                                    end 
                                else
                                    if not ThisIsUtilForLocalScript then 
                                        TriggerEvent("OnPedKilledByPed",victim, attacker, weaponHash, isMeleeDamage)
                                    elseif OnPedKilledByPed then   
                                        OnPedKilledByPed(victim, attacker, weaponHash, isMeleeDamage)
                                    end 
                                end
                            end
                        else
                            if IsPedAPlayer(victim) then
                                if not ThisIsUtilForLocalScript then 
                                    TriggerEvent("OnPlayerDied", NetworkGetPlayerIndexFromPed(victim), attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                                elseif OnPlayerDied then    
                                    OnPlayerDied(NetworkGetPlayerIndexFromPed(victim), attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                                end 
                            end
                        end
                        if not ThisIsUtilForLocalScript then 
                            TriggerEvent("OnPedDied", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                        elseif OnPedDied then     
                            OnPedDied(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                        end 
                    else
                        if not ThisIsUtilForLocalScript then 
                            TriggerEvent("OnEntityKilled", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                        elseif OnEntityKilled then     
                            OnEntityKilled(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                        end 
                    end
                end
            else

                if not IsEntityAVehicle(victim)  then
                    if not ThisIsUtilForLocalScript then 
                        TriggerEvent("OnEntityDamaged", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                    elseif OnEntityDamaged then  
                        OnEntityDamaged(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                    end 
                else
                    if not ThisIsUtilForLocalScript then 
                        TriggerEvent("OnVehicleDamaged", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                    elseif OnVehicleDamaged then   
                        OnVehicleDamaged(victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                    end 
                end
            end
        end
    end
end
