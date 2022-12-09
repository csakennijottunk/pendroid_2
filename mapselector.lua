mapselectorTable = {
    functions = {
        setup = function (self)
            suit = require("Framework.suit")
            if (self) then
                self.map = 0
                self.dif = 0
                self.buttons = {
                    {
                        name = "PorSaturday",
                        click = function ()
                            self.map = 1
                        end,
                        width = 125,
                        height = 100,
                        x = 75,
                        y = 110
                    },
                    {
                        name = "Mars",
                        click = function ()
                            self.map = 2
                        end,
                        width = 125,
                        height = 100,
                        x = main.dimensions.w / 2 - 62,5,
                        y = 110
                        
                    },
                    {
                        name = "PeeLand",
                        click = function ()
                            self.map = 3
                        end,
                        width = 125,
                        height = 100,
                        x = main.dimensions.w - (main.dimensions.w / 4.5 + 50),
                        y = 110
                    },
                    {
                        name = "Easy",
                        click = function ()
                            self.dif = 1
                        end,
                        width = 125,
                        height = 100,
                        x = 75,
                        y = main.dimensions.h - 300
                    },
                    {
                        name = "Hard",
                        click = function ()
                            self.dif = 2
                        end,
                        width = 125,
                        height = 100,
                        x = main.dimensions.w / 2 - 62,5,
                        y = main.dimensions.h - 300
                    },
                    {
                        name = "So-so hard",
                        click = function ()
                            self.dif = 3
                        end,
                        width = 125,
                        height = 100,
                        x = main.dimensions.w - (main.dimensions.w / 4.5 + 50),
                        y = main.dimensions.h - 300

                    },
                    {
                        name = "Next",
                        click = function ()
                            if self.dif ~= 0 and self.map ~= 0 then
                                main.setScreen(main.screens.game)
                                main.screens.game.table.functions.setup(main.screens.game.table, dif, map)
                            end
                        end,
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