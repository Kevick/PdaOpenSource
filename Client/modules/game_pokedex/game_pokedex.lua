--Design
pokedexWindow = nil

--functions
Painel = {
	pokedex = {
		['pnlDescricao'] = "",
		['pnlAtaques'] = "",
		['pnlHabilidades'] = "",		
	}
}
openedDex = {}
dexMax = 0

function init()
	connect(g_game, { onEditText = showPokemonDescription, onGameEnd = hide } )
end

function showPokedex()
	if pokedexWindow then
		pokedexWindow:destroy()
	end
	pokedexWindow = g_ui.displayUI('game_pokedex')
end

function terminate()
	disconnect(g_game, { onEditText = showPokemonDescription, onGameEnd = hide } )
end

function hide()
	pokedexWindow:destroy()
end

function Painel.show(childName)	
	pokedexWindow:getChildById('pnlDescricao'):getChildById('lblConteudo'):setText(Painel.pokedex['pnlDescricao'])
	pokedexWindow:getChildById('pnlAtaques'):getChildById('lblConteudo'):setText(Painel.pokedex['pnlAtaques'])
	pokedexWindow:getChildById('pnlHabilidades'):getChildById('lblConteudo'):setText(Painel.pokedex['pnlHabilidades'])
	pokedexWindow:getChildById('pnlDescricao'):setVisible(false)
	pokedexWindow:getChildById('scrDescricao'):setVisible(false)
	pokedexWindow:getChildById('pnlAtaques'):setVisible(false)
	pokedexWindow:getChildById('scrAtaques'):setVisible(false)
	pokedexWindow:getChildById('pnlHabilidades'):setVisible(false)
	pokedexWindow:getChildById('scrHabilidades'):setVisible(false)
	
	pokedexWindow:getChildById(childName):setVisible(true)
	pokedexWindow:getChildById('scr'..childName:sub(4,#childName)):setVisible(true)
	
end



function showPokemonDescription(id, itemId, maxLength, texto, writter, time)
	if not g_game.isOnline() then return end	--Se nao estiver online
	local name = texto:match('Name: (.-)\n')
	local type = texto:match('Type: (.-)\n')
	--Se for chamada de pokedex
	if name and type then 
		showPokedex()
		
		--Required Level
		local requieredLevel = texto:match('Required level: (.-)\n')
		
		--Evolution Description
		local evoDesc = texto:match('\nEvolutions:\n(.-)\n')
		
		--MOVES
		local moves = texto:match('\nMoves:\n(.-)\nAbility:')
		
		--Ability
		local ability = texto:sub(texto:find('Ability:\n')+9,#texto)
		
		pokedexWindow:getChildById('lblPokeName'):setText(name)
		if name:find("Shiny") then
			name = name:sub(7,#name)
			pokedexWindow:getChildById('lblPokeName'):setColor("red")
		end
		local f = io.open("modules/game_pokedex/imagens/pokemons/"..name..".png","r");
		if not f then
			print("Not found poke image called "..name)
		else
			f:close()
			pokedexWindow:getChildById('imgPokemon'):setImage("/game_pokedex/imagens/pokemons/"..name..".png")
		end
		Painel.pokedex["pnlDescricao"] = "Tipo: "..type.."\nNivel Requerido: "..requieredLevel.."\n\nEvolucoes:\n"..evoDesc
		Painel.pokedex["pnlAtaques"] = moves
		Painel.pokedex["pnlHabilidades"] = ability
		Painel.show('pnlDescricao')
	end
end