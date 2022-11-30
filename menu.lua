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
            name = "Play",
            click = function ()
                main.setScreen(main.screens.mapselector)
            end,
            plus = 0,
        },
        {
            name = "Developers",
            click = function ()
                main.setScreen(main.screens.credits)
            end,
            plus = 75,
        },
        {
            name = "Exit",
            click = function ()
                love.event.quit()
            end,
            plus = 150; 
        },
    }
}

function menuTable.functions.update(dt)
    for i,v in pairs(menuTable.buttons) do
        --#TODO megcsinálni az imagebuttonoket hogy mukodjenek es ne toltse be mindig ujra a texturajukat.
        if suit.ImageButton(main.images.buttons.start.active, {active=main.images.buttons.start.pressed},(main.dimensions.w/2) - (100 * main.dimensions.drawScaleX), (150 + v.plus) ,0.2,0.2).hit then
            v.click()
        end
    end
end

function menuTable.functions.draw()
    suit.draw()
end