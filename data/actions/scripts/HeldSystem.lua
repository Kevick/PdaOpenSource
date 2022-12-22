local heldTable = {
-- X --
[13976] = {attribute = "heldx", ident = 1}, -- Defense 1
[13977] = {attribute = "heldx", ident = 2}, -- Defense 2
[13978] = {attribute = "heldx", ident = 3}, -- Defense 3
[13979] = {attribute = "heldx", ident = 4}, -- Defense 4
[13980] = {attribute = "heldx", ident = 5}, -- Defense 5
[13981] = {attribute = "heldx", ident = 6}, -- Defense 6
[13982] = {attribute = "heldx", ident = 7}, -- Defense 7
[13948] = {attribute = "heldx", ident = 8}, -- Attack 1
[13949] = {attribute = "heldx", ident = 9}, -- Attack 2
[13950] = {attribute = "heldx", ident = 10}, -- Attack 3
[13951] = {attribute = "heldx", ident = 11}, -- Attack 4
[13952] = {attribute = "heldx", ident = 12}, -- Attack 5
[13953] = {attribute = "heldx", ident = 13}, -- Attack 6
[13954] = {attribute = "heldx", ident = 14}, -- Attack 7
[13969] = {attribute = "heldx", ident = 15}, -- Return 1
[13970] = {attribute = "heldx", ident = 16}, -- Return 2
[13971] = {attribute = "heldx", ident = 17}, -- Return 3
[13972] = {attribute = "heldx", ident = 18}, -- Return 4
[13973] = {attribute = "heldx", ident = 19}, -- Return 5
[13974] = {attribute = "heldx", ident = 20}, -- Return 6
[13975] = {attribute = "heldx", ident = 21}, -- Return 7
[13962] = {attribute = "heldx", ident = 22}, -- Hellfire 1
[13963] = {attribute = "heldx", ident = 23}, -- Hellfire 2 
[13964] = {attribute = "heldx", ident = 24}, -- Hellfire 3
[13965] = {attribute = "heldx", ident = 25}, -- Hellfire 4 
[13966] = {attribute = "heldx", ident = 26}, -- Hellfire 5
[13967] = {attribute = "heldx", ident = 27}, -- Hellfire 6
[13968] = {attribute = "heldx", ident = 28}, -- Hellfire 7
[13955] = {attribute = "heldx", ident = 29}, -- Poison 1
[13956] = {attribute = "heldx", ident = 30}, -- Poison 2
[13957] = {attribute = "heldx", ident = 31}, -- Poison 3
[13958] = {attribute = "heldx", ident = 32}, -- Poison 4
[13959] = {attribute = "heldx", ident = 33}, -- Poison 5
[13960] = {attribute = "heldx", ident = 34}, -- Poison 6
[13961] = {attribute = "heldx", ident = 35}, -- Poison 7
[13990] = {attribute = "heldx", ident = 36}, -- Boost 1
[13991] = {attribute = "heldx", ident = 37}, -- Boost 2
[13992] = {attribute = "heldx", ident = 38}, -- Boost 3
[13993] = {attribute = "heldx", ident = 39}, -- Boost 4
[13994] = {attribute = "heldx", ident = 40}, -- Boost 5
[13995] = {attribute = "heldx", ident = 41}, -- Boost 6
[13996] = {attribute = "heldx", ident = 42}, -- Boost 7
-- Y -- 
[13941] = {attribute = "heldy", ident = 1}, -- Regeneration 1
[13942] = {attribute = "heldy", ident = 2}, -- Regeneration 2
[13943] = {attribute = "heldy", ident = 3}, -- Regeneration 3
[13944] = {attribute = "heldy", ident = 4}, -- Regeneration 4
[13945] = {attribute = "heldy", ident = 5}, -- Regeneration 5
[13946] = {attribute = "heldy", ident = 6}, -- Regeneration 6
[13947] = {attribute = "heldy", ident = 7}, -- Regeneration 7
[13983] = {attribute = "heldy", ident = 8}, -- Cure 1 
[13984] = {attribute = "heldy", ident = 9}, -- Cure 2
[13985] = {attribute = "heldy", ident = 10}, -- Cure 3
[13986] = {attribute = "heldy", ident = 11}, -- Cure 4
[13987] = {attribute = "heldy", ident = 12}, -- Cure 5
[13988] = {attribute = "heldy", ident = 13}, -- Cure 6
[13989] = {attribute = "heldy", ident = 14}, -- Cure 7
}

function onUse(cid, item, frompos, item2, topos)

if not isPokeball(item2.itemid) or #getCreatureSummons(cid) > 0 then return false end
if not heldTable[item.itemid] then return false end

held = heldTable[item.itemid]
pokename = getItemAttribute(item2.uid, "poke")
heldname = getItemInfo(item.itemid).name

doSetItemAttribute(item2.uid, held.attribute, held.ident)
doRemoveItem(item.uid, 1)
doSendMagicEffect(getThingPos(cid), 14)
sendMsgToPlayer(cid, 27, "Your "..pokename.." has gained a "..heldname..".")
return true
end