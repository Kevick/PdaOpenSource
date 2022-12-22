--- Developed By : OrochiElf (Tony Araújo) ~~ www.OTCodes.com ~~
CatcherWindow = nil

function init()
	CatcherWindow = g_ui.displayUI('CatcherWindow.otui')
	CatcherWindow:hide()

	connect(g_game, 'onTextMessage', serverComunication)
	connect(g_game, { onGameEnd = hide } )
end

function terminate()
	disconnect(g_game, { onGameEnd = hide })
	disconnect(g_game, 'onTextMessage', serverComunication)
end

function hide()
	CatcherWindow:destroy()
end

function CatcherWindowHide()
	CatcherWindow:hide()
end

function serverComunication(mode, text)
	if not g_game.isOnline() then
		return
	end

	if mode == MessageModes.Failure then
		if text:find("%#CatcherWindow") then
			local search = text:explode("@")

			CatcherWindow:show()
			CatcherWindow:recursiveGetChildById("ImagePortrait"):setItemId(search[2])
			CatcherWindow:recursiveGetChildById("PokeName"):setText("You catched a ".. search[3])
			CatcherWindow:recursiveGetChildById("Experience"):setText("You won ".. search[4] .." XP")

			local pb = text:match("pb=(.-),")
			local gb = text:match("gb=(.-),")
			local sb = text:match("sb=(.-),")
			local ub = text:match("ub=(.-),")

			local allballs = tonumber(pb + gb + sb + ub)

			CatcherWindow:recursiveGetChildById("CountPB"):setText(pb.." PokeBalls")
			CatcherWindow:recursiveGetChildById("CountGB"):setText(gb.." GreatBalls")
			CatcherWindow:recursiveGetChildById("CountSB"):setText(sb.." SuperBalls")
			CatcherWindow:recursiveGetChildById("CountUB"):setText(ub.." UltraBalls")

			CatcherWindow:recursiveGetChildById("TotalBalls"):setText("Total balls used: "..allballs)
		end
	end
end

