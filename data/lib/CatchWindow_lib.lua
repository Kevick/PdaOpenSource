-- V1.3 ->Developed by: Tony Araújo (OrochiElf) ~~ www.OTCodes.com ~~
 
CW_Pokes = {
        ["bulbasaur"] = {DB_Balls = 500001, DB_PK = 900001, ID_Portrait = 11989, P_Experience = 5000},
        ["ivysaur"] = {DB_Balls = 500002, DB_PK = 900002, ID_Portrait = 11990, P_Experience = 10000},
        ["venusaur"] = {DB_Balls = 500003, DB_PK = 900003, ID_Portrait = 11991, P_Experience = 15000},
}
 
CW_Balls = {
        ["normal"] = "pb", -- PokeBall
        ["great"] = "gb", -- GreatBall
        ["super"] = "sb", -- SuperBall
        ["ultra"] = "ub", -- UltraBall
}
 
-------- Functions ----------
function CW_Count(cid, pokeName, ball)
        local name = nil
        if tostring(pokeName) then
 
                name = pokeName:lower()
        else
 
                name = getCreatureName(pokeName):lower()
        end
 
        local pk = CW_Pokes[name]
 
        if pk then
                if tonumber(getPlayerStorageValue(cid, pk.DB_Balls)) then
 
                        setPlayerStorageValue(cid, pk.DB_Balls, "pb=0,gb=0,sb=0,ub=0,")
                end
 
                local txt = getPlayerStorageValue(cid, pk.DB_Balls)
                local change = txt:match(CW_Balls[ball].."=(.-),")
                local num = tonumber(change)
 
                local ret = string.gsub(txt, CW_Balls[ball].."="..num, CW_Balls[ball].."="..(num+1))
                return setPlayerStorageValue(cid, pk.DB_Balls, ret) and true
        end
end
 
function CW_Caught(cid, pokeName)
        local name = nil
        if tostring(pokeName) then
 
                name = pokeName:lower()
        else
 
                name = getCreatureName(pokeName):lower()
        end
 
        local pk = CW_Pokes[name]
 
        if pk then
                if getPlayerStorageValue(cid, pk.DB_PK) <= 0 then
 
                        doPlayerSendCancel(cid, "%#CatcherWindow@"..getItemInfo(pk.ID_Portrait).clientId.."@"..pokeName.."@"..pk.P_Experience.."@"..getPlayerStorageValue(cid, pk.DB_Balls))
                        setPlayerStorageValue(cid, pk.DB_Balls, "pb=0,gb=0,sb=0,ub=0,")
                        doPlayerAddExp(cid, pk.P_Experience)
                        setPlayerStorageValue(cid, pk.DB_PK, 1)
                end
        end
        return true
end