local config = {
	idleWarning = getConfigValue('idleWarningTime'),
	idleKick = getConfigValue('idleKickTime')
}



function onThink(cid, interval)
if not isCreature(cid) then return true end

if(getTileInfo(getCreaturePosition(cid)).nologout or getCreatureNoMove(cid) or getPlayerCustomFlagValue(cid, PLAYERCUSTOMFLAG_ALLOWIDLE)) then
   return true
end

if getCreatureOutfit(cid).lookType == 814 then return true end   --alterado v1.9

local idleTime = getPlayerIdleTime(cid) + interval
doPlayerSetIdleTime(cid, idleTime)

if(config.idleKick > 0 and idleTime > config.idleKick) then
   doRemoveCreature(cid)
elseif(config.idleWarning > 0 and idleTime == config.idleWarning) then
   local message = "You have been idle for " .. math.ceil(config.idleWarning / 30000) .. " minutes"
   if(config.idleKick > 0) then
      message = message .. ", you will be disconnected in "
      local diff = math.ceil((config.idleWarning - config.idleKick) / 30000)
      if(diff > 1) then
         message = message .. diff .. " minutes"
      else
         message = message .. "one minute"
      end
      message = message .. " if you are still idle"
   end
   doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, message .. ".")
end
return true
end