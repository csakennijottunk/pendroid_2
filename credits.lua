creditsTable = {
    functions = {
        setup = function ()
            if (creditsTable.elements ~= nil) then
                print("Elemnentek feltöltve.")
            end
        end,
        update = nil,
        draw = nil,
    },
    elements = {},
}

function creditsTable.functions.update(dt)
    print("asd")
end

function creditsTable.functions.draw()
    
end