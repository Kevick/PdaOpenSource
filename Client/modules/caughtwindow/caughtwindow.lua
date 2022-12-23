---------------------------------------------------------------
----------- [OTClient-MODULE] CAUGHT WINDOW v: 1.4 ------------
--------------- Author: Tony Araújo (OrochiElf) ---------------
------------------------- 05/05/2020 --------------------------
---------------------------------------------------------------
local caughtWindow = nil

function init()
    caughtWindow = g_ui.displayUI("caughtwindow.otui")
    caughtWindow:hide()

    connect(g_game, { onGameEnd = hide })
    connect(g_game, 'onTextMessage', parse)
    --ProtocolGame.registerExtendedOpcode(205, function(protocol, opcode, buffer) parse(buffer) end) -- Opcode
end

function terminate()
    caughtWindow:destroy()

    disconnect(g_game, { onGameEnd = hide })
    disconnect(g_game, 'onTextMessage', parse)
    --ProtocolGame.unregisterExtendedOpcode(205) -- Opcode
end

function hide()
    if caughtWindow:isVisible() then
      caughtWindow:hide()
    end
end

-- function parse(text) -- Opcode
function parse(mode, text)
    if not g_game.isOnline() then
        return
    end
    if mode == MessageModes.Failure then
        if text:find("$CaughtWindow") then
            local params = text:explode("&")
            caughtWindow:setHeight(140 + (30 * (#params - 4)))
            caughtWindow:show()

            local item_portrait = caughtWindow:getChildById("Item_Portrait")
            item_portrait:setItemId(tonumber(params[2]))

            local label_caught = caughtWindow:getChildById("Label_Caught")
            label_caught:setText("You caught a " .. params[3] .. ",")

            local label_exp = caughtWindow:getChildById("Label_Exp")
            label_exp:setText("and won " .. params[4] .. " exp.")

            local panel_balls = caughtWindow:getChildById("Panel_Pokeballs")
            panel_balls:setHeight((30 * (#params - 4)) + 5)

            --// Clear Panel Childs
            for i = 1, #panel_balls:getChildren() do
                panel_balls:getChildren()[i]:destroy()
            end

            for i = 5, #params do
                local newball = g_ui.createWidget("Pokeball", panel_balls)
                local info = params[i]:explode("@")
                
                local item_ball = newball:getChildById("Item_Ball")
                item_ball:setItemId(tonumber(info[1]))
                
                local label_ball = newball:getChildById("Label_Ball")
                label_ball:setText(info[2])

                if i == 5 then
                    newball:addAnchor(AnchorTop, 'parent', AnchorTop)
                else
                    newball:addAnchor(AnchorTop, 'prev', AnchorBottom)
                end
            end
            return true
        end
    end 
end