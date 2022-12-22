function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Explosion gas")

return true
end