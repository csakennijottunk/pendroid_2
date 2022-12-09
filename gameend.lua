gameendTable = {
    functions = {
        setup = function (self)
            suit = require("Framework.suit")
            if (self) then
                self.buttons = {
                    {
                        name = "Return to menu",
                        click = function ()
                            main.setScreen(main.screens.menu)
                        end,
                        width = 150,
                        height = 50,
                        x = main.dimensions.w / 2 - 75,
                        y = main.dimensions.h / 1.5
                    },
                }
                self.text = {
                    nicetry = {
                        text = love.graphics.newText(font, ""),
                        x = main.dimensions.w / 2 - 175,
                        y = main.dimensions.h / 2 - 150,
                    },
                    score = {
                        text = love.graphics.newText(font, "Your score: " .. gameTable.score),
                        x = main.dimensions.w / 2.55,
                        y = main.dimensions.h / 2.2,
                    },
                }
                if (gameTable.gamestate) then
                    self.text.nicetry.text:set("VICTORY!")
                else
                    self.text.nicetry.text:set("LOSE!")
                end
            end
        end,
        update = nil,
        draw = nil,
        
    },
    elements = {},
}
function gameendTable.functions:update(dt)
    for i,v in pairs(gameendTable.buttons) do
        if suit.Button(v.name,v.x, v.y,v.width,v.height).hit then
            v.click()
        end
    end
end 

function gameendTable.functions.draw()
    for i,v in pairs(gameendTable.text)do
        love.graphics.draw(v.text, v.x, v.y)
    end
    suit.draw()
end