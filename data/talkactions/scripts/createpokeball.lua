function onSay(cid, words, param)

local typess = {
[1] = "normal",
[2] = "great",
[3] = "super",
[4] = "ultra"
}

if param == "" then
doPlayerSendCancel(cid, 'Command needs parameters, function structure: "/cb [Pokemon Name], [boost], [Gender]".')
return 0
end

local t = string.explode(param, ",")

local name = ""
local gender = 0
local btype = typess[math.random(1, 4)]                --"normal"
local typeee = typess[math.random(1, 4)]

if t[1] then
	local n = string.explode(t[1], " ")
	local str = string.sub(n[1], 1, 1)
	local sta = string.sub(n[1], 2, string.len(n[1]))
	name = ""..string.upper(str)..""..string.lower(sta)..""
	if n[2] then
	str = string.sub(n[2], 1, 1)
	sta = string.sub(n[2], 2, string.len(n[2]))
	name = name.." "..string.upper(str)..""..string.lower(sta)..""
	end
	if not pokes[name] then
	doPlayerSendCancel(cid, "Sorry, a pokemon with the name "..name.." doesn't exists.")
	return true
	end
print(""..name.." ball has been created by "..getPlayerName(cid)..".")
end

local genders = {
["male"] = 4,
["female"] = 3,
["1"] = 4,
["0"] = 3}

if t[3] then
	if genders[t[3]] then
		gender = genders[t[3]]
	else
	local rate = newpokedex[name].gender
		if rate == 0 then
			gender = 3
		elseif rate == 1000 then
			gender = 4
		elseif rate == -1 then
			gender = 0
		elseif math.random(1, 1000) <= rate then
			gender = 4
		else
			gender = 3
		end
	end
	else
	local rate = newpokedex[name].gender
		if rate == 0 then
			gender = 3
		elseif rate == 1000 then
			gender = 4
		elseif rate == -1 then
			gender = 0
		elseif math.random(1, 1000) <= rate then
			gender = 4
		else
			gender = 3
		end
end

local mypoke = pokes[name]
local happy = 255

local item = doCreateItemEx(2219)
doItemSetAttribute(item, "poke", name)
doItemSetAttribute(item, "hp", 1)
if t[2] and tonumber(t[2]) > 0 and tonumber(t[2]) <= 50 then
   doItemSetAttribute(item, "boost", tonumber(t[2]))
end
doItemSetAttribute(item, "happy", happy)
doItemSetAttribute(item, "gender", gender)
if name == "Shiny Hitmonchan" or name == "Hitmonchan" then
   doItemSetAttribute(item, "hands", 0)
end
doItemSetAttribute(item, "description", "Contains a "..name..".")
doItemSetAttribute(item, "fakedesc", "Contains a "..name..".")
local x = icons[getItemAttribute(item, "poke")]
	    doPlayerAddItemEx(cid, item, true)		
		doItemSetAttribute(item, "ball", "Icone")
		doItemSetAttribute(item, "icon", "yes")
		doItemSetAttribute(item, "morta", "no")
	    doTransformItem(item, x.on)		
return 1
end