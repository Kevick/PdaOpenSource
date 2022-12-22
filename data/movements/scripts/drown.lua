local condition = createConditionObject(CONDITION_DROWN)
setConditionParam(condition, CONDITION_PARAM_PERIODICDAMAGE, 0)
setConditionParam(condition, CONDITION_PARAM_TICKS, -1)
setConditionParam(condition, CONDITION_PARAM_TICKINTERVAL, 2000)

function onStepIn(cid, item, position, fromPosition)
	if(isPlayer(cid)) then
		doAddCondition(cid, condition)

local pk = getCreatureSummons(cid)[1]

doChangeSpeed(cid, -getCreatureSpeed(cid))
doChangeSpeed(cid, PlayerSpeed+400)
	end
	return true
end

function onStepOut(cid, item, position, fromPosition)
	doRemoveCondition(cid, CONDITION_DROWN)

local pk = getCreatureSummons(cid)[1]

doChangeSpeed(cid, -getCreatureSpeed(cid))
doChangeSpeed(cid, PlayerSpeed+400)
	return true
end
