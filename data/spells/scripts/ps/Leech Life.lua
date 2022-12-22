function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Leech Life")

return true
end