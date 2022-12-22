local config = {
    positions = {
        ["OutlandSul"] = { x = 1010, y = 1049, z = 13 },   
        ["OutlandNorte"] = { x = 1049, y = 1031, z = 13 }, 
        ["OutlandLeste"] = { x = 1057, y = 1060, z = 13 },
        ["Johto"] = { x = 965, y = 1066, z = 13 }, 
        ["Outlands"] = { x = 968, y = 1066, z = 13 }, 

        ["BoostMachines"] = { x = 0, y = 0, z = 0 },
        ["Coliseum"] = { x = 0, y = 0, z = 0 },

        ["Sala de Eventos"] = { x = 971, y = 1062, z = 14 },
		["AREA VIP"] = { x = 0, y = 0, z = 0 },

        ["Phenac"] = { x = 962, y = 1065, z = 13 },
    }
}

function onThink(cid, interval, lastExecution)
    for text, pos in pairs(config.positions) do
        doSendAnimatedText(pos, text, math.random(1, 255))
    end
    
    return TRUE
end  