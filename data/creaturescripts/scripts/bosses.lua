-- by GodMarini for TibiaKing Fórum. --
local pokemons = {"Raikou", "Mew","Zapdos", "Moltres", "Articuno","Entei","Mewtwo","Lugia","Lugia","Ho-oh","Celebi","Suicune"}


function onKill(cid, target, lastHit)
	if isInArray(pokemons,getCreatureName(target)) then
		doBroadcastMessage("O jogador "..getCreatureName(cid).." matou o Pokemon Lendario "..getCreatureName(target).."!")
	end
	return true


end