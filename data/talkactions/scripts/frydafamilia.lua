local configuration = {
    storage = 918311,
    fly_storage = 17000,    --Storage do Fly no seu servidor.
}
function isWalkable(pos, creature, proj, pz)-- by Nord
    if getTopCreature(pos).uid > 0 and creature then return false end
    if getTileInfo(pos).protection and pz then return false, true end
    local n = not proj and 3 or 2
    for i = 0, 255 do
        pos.stackpos = i
        local tile = getTileThingByPos(pos)
        if tile.itemid ~= 0 and not isCreature(tile.uid) then
            if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
                return false
            end
        end
    end
    return true
end  
function autoWalk(cid, id)
    if not isCreature(cid) then 
        if id then
            return db.executeQuery("UPDATE player_storage SET value = -1 WHERE key = 918311 AND player_id = "..id)
        end
    elseif getPlayerStorageValue(cid, configuration.storage) < 1 then
        return true
    end
    local topos = getPosByDir(getThingPos(cid), getCreatureLookDir(cid))
    if topos then
        if getPlayerStorageValue(cid, configuration.storage) < 1 or getPlayerStorageValue(cid, configuration.fly_storage) < 1 then
            if getPlayerStorageValue(cid, configuration.fly_storage) < 1 then
                setPlayerStorageValue(cid, configuration.storage, -1)
            end
            return true
        elseif isWalkable(topos) then
            if getTileThingByPos({x = topos.x, y = topos.y, z = topos.z, stackpos = 0}).itemid == 0 then
                doCombatAreaHealth(cid, 0, topos, 0, 0, 0, CONST_ME_NONE)
                doCreateItem(11676, 1, topos)
            end
            doTeleportThing(cid, topos)
        else
            setPlayerStorageValue(cid, configuration.storage, -1)
            doPlayerSendTextMessage(cid, 27, "Há algum objeto à sua frente impedindo a passagem.")
            doPlayerSetNoMove(cid, false)
            return true
        end
    else
        doPlayerSendCancel(cid, "Sorry, not possible.")
        setPlayerStorageValue(cid, configuration.storage, -1)
        doPlayerSetNoMove(cid, false)
        return true
    end
    addEvent(autoWalk, 500, cid, id)
end
function onSay(cid, words)
    if getPlayerStorageValue(cid, configuration.fly_storage) < 1 then
        doPlayerSendCancel(cid, "Para usar este comando, você deve estar em Fly.")
    elseif getPlayerStorageValue(cid, configuration.storage) >= 1 then
        setPlayerStorageValue(cid, configuration.storage, -1)
        doPlayerSendTextMessage(cid, 27, "Comando !fly desativado.")
        doPlayerSetNoMove(cid, false)
    else
        doPlayerSendTextMessage(cid, 27, "Comando !fly ativado.")
        setPlayerStorageValue(cid, configuration.storage, 1)
        doPlayerSetNoMove(cid, true)
        autoWalk(cid, getPlayerGUID(cid))
    end
    return true
end