local config = {
    cash = xxx,                                    --Valor inicial da loteria.
    limit = {1, 200},                              --Número mínimo e máximo da loteria.
    numbers = 3,                                   --Quantos números o player deve escolher.
    startTime = 5,                                 --Tempo para as apostas serem fechadas/anunciar vencedor, em minutos.
    messages = {                                   --Mensagens.
        "A loteria está aberta, façam suas apostas! Tempo até fechar: %d minuto(s).\nDinheiro acumulado até agora: %s.",
        "A loteria está fechada!\nPrêmio (individual): %s gold. Vencedor%s: %s.",
        "Sem vencedores na loteria!\nDinheiro acumulado [total]: %s gold.",
    },
    storages = {9571, 9572, 9573},
}
function onThink()
    setGlobalStorageValue(config.storages[1], 1)
    if getGlobalStorageValue(config.storages[2]) < 0 then
        setGlobalStorageValue(config.storages[2], config.cash)
    end
    broadcastMessage(config.messages[1]:format(config.startTime, pointNumber(getGlobalStorageValue(config.storages[2]))), MESSAGE_INFO_DESCR)
    for i = 1, config.startTime do
        addEvent(function()
            if i ~= config.startTime then
                broadcastMessage(config.messages[1]:format(config.startTime - i), MESSAGE_INFO_DESCR)
            else
                local sortedNumbers = {}
                for i = 1, config.numbers do
                    local value = math.random(config.limit[1], config.limit[2])
                    if isInArray(sortedNumbers, value) then
                        while isInArray(sortedNumbers, value) do
                            value = math.random(config.limit[1], config.limit[2])
                        end
                    end
                    table.insert(sortedNumbers, value)
                end
                setGlobalStorageValue(config.storages[1], -1)
                local winners, str = getLotteryWinners(sortedNumbers, config.numbers), ""
                local prize = math.floor(getGlobalStorageValue(config.storages[2]) / #winners)
                if #winners > 0 then
                    for i = 1, #winners do
                        if str == "" then
                            str = getCreatureName(winners[i])
                        else
                            str = str..(i == #winners and " e " or ", ")..getCreatureName(winners[i])
                        end
                    end
                end
                if str == "" then
                    broadcastMessage(config.messages[3]:format(pointNumber(getGlobalStorageValue(config.storages[2]))), MESSAGE_INFO_DESCR)
                else
                    broadcastMessage(config.messages[2]:format(pointNumber(prize), #winners > 1 and "es" or "", str), MESSAGE_INFO_DESCR)
                    setGlobalStorageValue(config.storages[2], -1)
                    for i = 1, #winners do
                        if isPlayer(winners[i]) then
                            doPlayerDepositMoney(winners[i], prize)
                            doPlayerSendTextMessage(winners[i], MESSAGE_STATUS_CONSOLE_ORANGE, "Por vencer a loteria, você recebeu: "..prize.." gold.")
                        end
                    end
                end
                resetStorage(config.storages[3], config.numbers)
            end
        end, i * 60 * 1000)
    end
    return true
end