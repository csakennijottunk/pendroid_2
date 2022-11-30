gameendTable = {
    functions = {
        setup = function (self)
            suit = require("Framework.suit")
            if (self) then
                self.map = 0
                self.dif = 0
            end
        end,
        update = nil,
        draw = nil,
    },
    buttons = {
        {
            name = "Back to menu",
            click = function ()
                main.setScreen(main.screens.menu)   
            end,
            --TODO valamiert nem latja a main-t ez a cucc
            width =  30,--main.dimensions.w / 4.5,
            height =  30,--main.dimensions.h / 1.5,
            x = 50,
            y = 30
        }
    }    
}

function gameendTable.functions.update(dt)
    for i,v in pairs(gameendTable.buttons) do
        if suit.Button(v.name,(main.dimensions.w/2) - (100 * main.dimensions.drawScaleX), (150) ,200  * main.dimensions.drawScaleX,75 * main.dimensions.drawScaleX).hit then
            v.click()
        end
    end
end

function gameendTable.functions.draw()
    suit.draw();
end

