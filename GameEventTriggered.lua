local IsUntilForLocalUse = false 

AddEventHandler('gameEventTriggered',function(name,args)
    GameEventTriggered(name,args)
end)

if IsUntilForLocalUse then 
    TriggerEvent = function(func,...)
        local a = {...}
        _G[func](...)
    end 
end 

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
                    TriggerEvent("OnVehicleDestroyed", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag);

                else

                    if IsEntityAPed(victim) then
                        if IsEntityAVehicle(attacker) then
                            TriggerEvent("OnPedKilledByVehicle", victim, attacker, weaponHash);
                        elseif IsEntityAPed(attacker)  then
                            if IsPedAPlayer(attacker) then
                                player = NetworkGetPlayerIndexFromPed(attacker);
                                if IsPedAPlayer(victim) then
                                    TriggerEvent("OnPlayerKilledByPlayer", NetworkGetPlayerIndexFromPed(victim), NetworkGetPlayerIndexFromPed(attacker), weaponHash, isMeleeDamage);
                                else 
                                     TriggerEvent("OnPedKilledByPlayer", victim, player, weaponHash, isMeleeDamage);
                                    
                                end 
                            else
                                if IsPedAPlayer(victim) then
                                    TriggerEvent("OnPlayerKilledByPed", NetworkGetPlayerIndexFromPed(victim), attacker, weaponHash, isMeleeDamage);
                                else
                                    TriggerEvent("OnPedKilledByPed",victim, attacker, weaponHash, isMeleeDamage);
                                end
                            end
                        else
                            if IsPedAPlayer(victim) then
                                TriggerEvent("OnPlayerDied", NetworkGetPlayerIndexFromPed(victim), attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag);
                            end
                        end
                        TriggerEvent("OnPedDied", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag);
 
                    else
                        TriggerEvent("OnEntityKilled", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag);
                    end
                end
            else

                if not IsEntityAVehicle(victim)  then
                    TriggerEvent("OnEntityDamaged", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag);
                else
                    TriggerEvent("OnVehicleDamaged", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag);
                end
            end
        end
    end
end
