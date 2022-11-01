require("menu")
require("game")
require("credits")
main = {
    dimensions = {},
    setScreen = nil,
    currentScreen = nil,
    previousScreen = nil,
    screens = {
        menu = {
            table = menuTable,
        },
        game = {
            table = gameTable
        },
        credits = {
            table = creditsTable
        }
    },
    images = {
        badlogic = love.graphics.newImage("assets/badlogic.jpg"),
        earth = love.graphics.newImage("assets/earth.png"),
        kantsal = love.graphics.newImage("assets/kantsal.png"),
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