--- Created by Darkhaos

function onDeath(cid, corpse, killer)

        registerCreatureEvent(cid, "ArticunoTeleport")

        local creaturename = getCreatureName(cid)
        local in_pos = {x=580, y=1516, z=8, stackpos=2} 
        local checkIID = getThingfromPos(in_pos)
        local to_pos = {x=563, y=1517, z=8, stackpos=1} 
        local time_to_pass = 10 -- in seconds
        local tpID = 1387

    if creaturename == 'Articuno' then

                teleport = doCreateTeleport(tpID, to_pos, in_pos)

                doSendMagicEffect(in_pos, CONST_ME_TELEPORT)

                doCreatureSay(cid, "Parabens agora vc pode passar para proxima fase da quest", TALKTYPE_ORANGE_1)
                addEvent(removeTeleport, (1000*time_to_pass))

        
                end 
        end

function removeTeleport()
        if getThingfromPos({x=580, y=1516, z=8, stackpos=2} ).itemid == 1387 then
        doRemoveItem(getThingfromPos({x=580, y=1516, z=8, stackpos=2} ).uid,1)
        doSendMagicEffect({x=580, y=1516, z=8, stackpos=2} , CONST_ME_POFF)
        return TRUE
        end
end 