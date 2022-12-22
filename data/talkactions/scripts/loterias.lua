local config = {
    limit = {1, 200},                              --Número mínimo e máximo da loteria.
    numbers = 3,                                   --Quantos números o player deve escolher.
    price = xxx,                                   --Preço para participar da loteria.
    storages = {9571, 9572, 9573},
}    
function onSay(cid, words, param)
    if getGlobalStorageValue(config.storages[1]) < 1 then
        doPlayerSendCancel(cid, "A loteria está fechada.")
    elseif getPlayerStorageValue(cid, config.storages[3]) ~= -1 then
        doPlayerSendCancel(cid, "Você já fez sua aposta.")
    elseif param == "" then
        doPlayerSendCancel(cid, "!apostar number1 number2 number3")
    elseif getPlayerMoney(cid) < config.price then
        doPlayerSendCancel(cid, "Você precisa de, no mínimo, "..config.price.." gold para apostar.")
    else
        local numbers = param:explode(" ")
        if #numbers ~= config.numbers then
            doPlayerSendCancel(cid, "Escolha "..config.numbers.." números, entre "..config.limit[1].." - "..config.limit[2]..".")
        else           
            local str = ""
            for i = 1, #numbers do
                numbers[i] = tonumber(numbers[i])
                if not numbers[i] or numbers[i] < config.limit[1] or numbers[i] > config.limit[2] then
                    return doPlayerSendCancel(cid, "Escolha números válidos ["..config.limit[1].." - "..config.limit[2].."].")
                end
                if str == "" then
                    str = numbers[i]
                else
                    str = str..(i == #numbers and " e " or ", ")..numbers[i]
                end
            end
            doPlayerRemoveMoney(cid, config.price)
            doPlayerSendTextMessage(cid, 27, "Você escolheu os números: "..str..".")
            for i = 0, config.numbers - 1 do
                setPlayerStorageValue(cid, config.storages[3] + i, numbers[i + 1])
            end
            addGlobalStorageValue(config.storages[2], config.price)
        end
    end
    return true
end