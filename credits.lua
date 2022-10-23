font = love.graphics.newFont("assets/heavy_heap_rg.otf", 50)
creditsTable = {
    functions = {
        setup = function ()
            suit = require("Framework.suit")
            x = main.dimensions.w
            y = main.dimensions.h
            text = {
                credits = {
                    text = love.graphics.newText(font, "Credits"),
                    x = x / 2,
                    y = y / 2 - 200,
                },
                milan = {
                    text = love.graphics.newText(font, "Fellner Milán"),
                    x = x / 2,
                    y = y / 2 - 100,
                },
                bence = {
                    text = love.graphics.newText(font, "Németh Csaba Bence"),
                    x = x / 2,
                    y = y / 2,
                },
                kancsal = {
                    text = love.graphics.newText(font, "Kancsal Máté"),
                    x = x / 2,
                    y = y / 2 + 100,
                },
                zsebok = {
                    text = love.graphics.newText(font, "Zsebők Dávid Ferenc"),
                    x = x / 2,
                    y = y / 2 + 200,
                }
            }
            for i,v in pairs(text)do
                v.x = v.x - v.text:getWidth() /2
            end
        end,
        update = nil,
        draw = nil,
        load = nil,
    },
}

function creditsTable.functions.update(dt)

end

function creditsTable.functions.draw()
    for i,v in pairs(text)do
        love.graphics.draw(v.text, v.x, v.y)
    end
end
