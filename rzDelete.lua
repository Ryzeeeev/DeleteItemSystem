
local table = "user_inventory"
local listItemDelete = {
    "assaultrifle",
    "microsmg",
    "compactrifle",
    "pistol50",
    "compactrifle",
    "sawnoffshotgun"
} 

function IfHasWeaponInItems(item, table)
    for k,v in pairs(table) do
        if v == item then
            return {item = item}
        end
    end
end

function DeleteSQL(argsName, owner)
    MySQL.Async.execute('DELETE FROM '..table..' WHERE item = @name AND identifier = @owner',{
     ['@name'] = argsName,
     ["@owner"] = owner
},
function(affectedRows)
    if affectedRows then
        print("[Ryze] - Delete item: "..argsName)
    end
  end)
end

RegisterCommand("DeleteAllWeaponList", function(source)
    if source ~= 0 then
        print("A guys test to run this IN-GAME")
        return
    end
    MySQL.Async.fetchAll('SELECT * FROM '..table..'', {}, function(result)
        for k,v in pairs(result) do
            if IfHasWeaponInItems(v.item, listItemDelete) then
                DeleteSQL(v.item, v.owner)
            end
        end
    end)    
end)
