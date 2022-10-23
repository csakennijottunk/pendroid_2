gameTable = {
    functions = {
        setup = function ()
            if (gameTable.elements ~= nil) then
                print("Elemnentek feltöltve.")
                for i=1,3 do
                    local el = createElement(nil,0,i*100,0.4,0.4,nil)
                    table.insert(gameTable.elements,el)
                end
            end
        end,
        update = nil,
        draw = nil,
    },
    elements = {},
}

    
function gameTable.functions.update(dt)
    print(dt)
    for i, v in pairs(gameTable.elements) do
        v.x = v.x + 2
    end
end

function gameTable.functions.draw()
    for i, v in pairs(gameTable.elements) do
        love.graphics.draw(v.img,v.x,v.y,0,v.w*main.dimensions.drawScaleX,v.h*main.dimensions.drawScaleY)
    end
end

function createElement(functions,x,y,w,h,img)
    return {
        functions = functions or {},
        x = x or 0,
        y = y or 0,
        w = w or 1,
        h = h or 1,
        img = love.graphics.newImage("assets/badlogic.jpg")
    }
end