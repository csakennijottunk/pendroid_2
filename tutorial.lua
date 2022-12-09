tutorialTable = {
    functions = {
        setup = function (self)
            suit = require("Framework.suit")
            if (self) then
                self.main_text = {
                    text = love.graphics.newText(love.graphics.getFont(),"A játék lényege, a bolygó közelébe zuhanó meteorok eltalálása, kiiktatása amivel pontszámot tudunk szerezni. \nAmennyiben az ido letelt és a bolygó nem robbant még fel, akkor GYOZELEM az eredmény, ellenkezo esetben VESZTETTÉL.")
                }
            end
        end,
        update = nil,
        draw = nil,
        
    },
    elements = {},
}

function tutorialTable.functions.update()
    if (suit.Button("JÁTÉK",main.dimensions.w/2 - main.dimensions.w/16,main.dimensions.h/2 - main.dimensions.w/16,main.dimensions.w/8,main.dimensions.w/8).hit) then
        main.setScreen(main.screens.mapselector)
    end
end

function tutorialTable.functions.draw()
    love.graphics.draw(tutorialTable.main_text.text, 0, 0)
    suit.draw()
end