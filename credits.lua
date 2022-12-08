font = love.graphics.newFont("assets/heavy_heap_rg.otf", 40)
creditsTable = {
    functions = {
        setup = function ()
            suit = require("Framework.suit")
            x = main.dimensions.w
            y = main.dimensions.h
            text = {
                credits = {
                    text = love.graphics.newText(font, "Developers"),
                    x = x / 2,
                    y = y / 2 - 200,
                },
                milan = {
                    text = love.graphics.newText(font, "Fellner Milán"),
                    x = x / 2,
                    y = y / 2 - 150,
                },
                bence = {
                    text = love.graphics.newText(font, "Németh Csaba Bence"),
                    x = x / 2,
                    y = y / 2 - 100,
                },
                kancsal = {
                    text = love.graphics.newText(font, "Kancsal Máté"),
                    x = x / 2,
                    y = y / 2 - 50,
                },
                zsebok = {
                    text = love.graphics.newText(font, "Zsebők Dávid Ferenc"),
                    x = x / 2,
                    y = y / 2,
                }
            }
            for i,v in pairs(text)do
                v.x = v.x - v.text:getWidth() /2
            end
        end,
        update = nil,
        draw = nil,
    },
    buttons = {
        {
        name = "Back",
        click = function ()
            main.setScreen(main.screens.menu)
        end,
        plus = 200;
        },
    }
}

function creditsTable.functions.update(dt)
    for i,v in pairs(creditsTable.buttons) do
        if suit.Button(v.name,10, 10,100, 30).hit then
            v.click()
        end
    end
end

function creditsTable.functions.draw()
    love.graphics.draw(background, 0, 0,  0,  0.7, 0.7)
    for i,v in pairs(text)do
        love.graphics.draw(v.text, v.x, v.y)
    end
    suit.draw()
end
