mapselectorTable = {
    functions = {
        setup = function (self)
            suit = require("Framework.suit")
            if (self) then
                self.buttons = {
                    {
                        name = "Map1",
                        click = function ()
                            main.setScreen(main.screens.game)
                        end,
                        map = 1,
                        width = main.dimensions.w / 4.5,
                        height = main.dimensions.h / 1.5,
                        x = 50,
                        y = 30
                    },
                    {
                        name = "Map2",
                        click = function ()
                            main.setScreen(main.screens.game)
                        end,
                        map = 2,
                        width = main.dimensions.w / 4.5,
                        height = main.dimensions.h / 1.5,
                        x = main.dimensions.w / 2 - main.dimensions.w / 4.5 / 2,
                        y = 30
                    },
                    {
                        name = "Map3",
                        click = function ()
                            main.setScreen(main.screens.game)
                        end,
                        map = 3,
                        width = main.dimensions.w / 4.5,
                        height = main.dimensions.h / 1.5,
                        x = main.dimensions.w - (main.dimensions.w / 4.5 + 50),
                        y = 30
                    },
                    {
                        name = "Dif1",
                        click = function ()
                            main.setScreen(main.screens.game)
                        end,
                        dif = 1,
                        width = 100,
                        height = 30,
                        x = 120,
                        y = main.dimensions.h - 150
                    },
                    {
                        name = "Dif2",
                        click = function ()
                            main.setScreen(main.screens.game)
                        end,
                        dif = 2,
                        width = 100,
                        height = 30,
                        x = main.dimensions.w / 2 - 50,
                        y = main.dimensions.h - 150
                    },
                    {
                        name = "Dif3",
                        click = function ()
                            main.setScreen(main.screens.game)
                        end,
                        dif = 3,
                        width = 100,
                        height = 30,
                        x = main.dimensions.w - (main.dimensions.w / 4.5 + 50),
                        y = main.dimensions.h - 150

                    },
                    {
                        name = "Next",
                        click = function ()
                            main.setScreen(main.screens.game)
                        end,
                        dif = 3,
                        width = 100,
                        height = 30,
                        x = main.dimensions.w  / 2 - 50,
                        y = main.dimensions.h - 50

                    },
                }
            end
        end,
        update = nil,
        draw = nil,
        
    },
    elements = {},
}
function mapselectorTable.functions:update(dt)
    for i,v in pairs(mapselectorTable.buttons) do
        if suit.Button(v.name,v.x, v.y,v.width,v.height).hit then
            v.click()
        end
    end
end 

function mapselectorTable.functions.draw()
    suit.draw()
end