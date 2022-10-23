menuTable = {
    functions = {
        setup = function ()
            suit = require("Framework.suit")
        end,
        update = nil,
        draw = nil,
    },
    elements = {},
    buttons = {
        {
            name = "Játék",
            click = function ()
                main.setScreen(main.screens.game)
            end,
            plus = 0,
        },
        {
            name = "Kreditek",
            click = function ()
                main.setScreen(main.screens.credits)
            end,
            plus = 100,
        },
        {
            name = "Kilépés",
            click = function ()
                love.event.quit()
            end,
            plus = 200; 
        },
    }
}

function menuTable.functions.update(dt)
    for i,v in pairs(menuTable.buttons) do
        if suit.Button(v.name,(main.dimensions.w/2) - (100 * main.dimensions.drawScaleX), (150 + v.plus) ,200  * main.dimensions.drawScaleX,75 * main.dimensions.drawScaleX).hit then
            v.click()
        end
    end
end

function menuTable.functions.draw()
    suit.draw()
end