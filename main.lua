require("menu")
require("game")
require("credits")
require("mapselector")
require("gameend")
require("tutorial")
main = {
    first_time = true,
    dimensions = {},
    setScreen = nil,
    currentScreen = nil,
    previousScreen = nil,
    screens = {
        menu = {
            table = menuTable,
        },
        mapselector = {
            table = mapselectorTable,
        },
        game = {
            table = gameTable
        },
        credits = {
            table = creditsTable
        },
        gamend = {
            table = gameendTable
        },
        tutorial = {
            table = tutorialTable,
        }
    },
    images = {
        badlogic = love.graphics.newImage("assets/badlogic.jpg"),
        star = love.graphics.newImage("assets/Star.png"),
        weapon = love.graphics.newImage("assets/weapon.png"),
        ammo = love.graphics.newImage("assets/ammo.png"),
        earth = love.graphics.newImage("assets/earth.png"),
        mars = love.graphics.newImage("assets/Mars.png"),
        saturn = love.graphics.newImage("assets/Saturn.png"),
        kantsal = love.graphics.newImage("assets/kantsal.png"),
        meteor = love.graphics.newImage("assets/Meteor.png"),
        shoot_button = love.graphics.newImage("assets/shoot_button.png"),
        ammo_indicator = love.graphics.newImage("assets/line.png"),
        buttons = {
            start = {
                active = love.graphics.newImage("assets/StartButton.png"),
                pressed = love.graphics.newImage("assets/startbuttonpressed.png"),
            }
        }
    },
    fonts = {
        main_font = ""
    }
}
--- Ez a funkció inicalizálja a love-ot a progriba.
function love.load()
    wf = require("Framework.windfield")
    main.dimensions.w,main.dimensions.h = love.graphics.getDimensions() -- jelenleg futó képernyőméret
    main.dimensions.aw,main.dimensions.ah = 360,480 -- mi általunk előredefiniált viszonyítási képernyőméret
    main.dimensions.drawScaleX,main.dimensions.drawScaleY = main.dimensions.w/main.dimensions.aw,main.dimensions.h/main.dimensions.ah -- a kettőnek az aránya segít scalelni androidra és más képernyőkre is
    --Betöltjük az összes képernyőnek az inicializáló metódusát.
    for i,v in pairs(main.screens) do
        v.table.functions.setup()
    end
    main.setScreen(main.screens.menu)
    main.dimensions.w,main.dimensions.h = love.graphics.getDimensions()
    main.dimensions.aw,main.dimensions.ah = 1080, 1920
    main.dimensions.drawScaleX,main.dimensions.drawScaleY = main.dimensions.w/main.dimensions.aw,main.dimensions.h/main.dimensions.ah
end
---Minden képkockában lefutó funkció.
---@param dt number
function love.update(dt)

    if (main.currentScreen ~= nil and main.currentScreen.table.functions.update~= nil) then
        main.currentScreen.table.functions.update(dt)
    end
end
---Minden képkockában lefutó rajzoló funkció
function love.draw()
    if (main.currentScreen ~= nil and main.currentScreen.table.functions.draw~= nil) then
        main.currentScreen.table.functions.draw()
    end
end
function love.touchpressed(id, x, y, dx, dy, pressure)
    if (main.currentScreen.table.functions.touchpressed ~= nil) then
        main.currentScreen.table.functions.touchpressed(id, x, y, dx, dy, pressure)
    end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    if (main.currentScreen.table.functions.touchreleased ~= nil) then
        main.currentScreen.table.functions.touchreleased(id, x, y, dx, dy, pressure)
    end
end

function love.touchmoved(id, x, y, dx, dy, pressure)
    if (main.currentScreen.table.functions.touchmoved ~= nil) then
        main.currentScreen.table.functions.touchmoved(id, x, y, dx, dy, pressure)
    end
end

function love.mousepressed(x, y, button, istouch, presses )
    if (main.currentScreen.table.functions.mousepressed ~= nil) then
        main.currentScreen.table.functions.mousepressed(x, y, button, istouch, presses)
    end
end

---Ez a funkció állítja be az aktív illetve előző képernyő értékét
---@param screen screen
function main.setScreen(screen)
    if (main.currentScreen ~= screen) then
            screen.table.functions.setup(screen.table)            
        main.currentScreen = screen
    end
end


function main.keypressed(key)
    if (main.currentScreen ~= nil and main.currentScreen.table.functions.key~= nil) then
        main.currentScreen.table.functions.key(key)
    end
end