function onSay(cid, words, param, channel)
local thisball = getPlayerSlotItem(cid, 8)
if thisball and getItemAttribute(thisball.uid, "ehditto") then
doDittoRevert(cid)
end
return true
end