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
}
--- Ez a funkció inicalizálja a love-ot a progriba.
function love.load()
    main.dimensions.w,main.dimensions.h = love.graphics.getDimensions() -- jelenleg futó képernyőméret
    main.dimensions.aw,main.dimensions.ah = 1080, 1920 -- mi általunk előredefiniált viszonyítási képernyőméret
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
    --love.graphics.scale(main.dimensions.w/main.dimensions.aw,main.dimensions.h/main.dimensions.ah)
    if (main.currentScreen ~= nil and main.currentScreen.table.functions.draw~= nil) then
        main.currentScreen.table.functions.draw()
    end
end
---Ez a funkció állítja be az aktív illetve előző képernyő értékét
---@param screen screen
function main.setScreen(screen)
    print("LEFUTOTT")
    if (screen ~= main.screens.menu or screen ~= nil) then
        main.previousScreen = main.currentScreen
    end
    if (main.currentScreen ~= screen) then
        main.currentScreen = screen
        main.currentScreen.table.functions.setup(main.previousScreen)
    end
end

function love.keypressed(key)
    if (key == "escape" or key == "appback") then
        main.setScreen(main.previousScreen)
    else
        main.keypressed(key)
    end
end

function main.keypressed(key)
    if (main.currentScreen ~= nil and main.currentScreen.table.functions.key~= nil) then
        main.currentScreen.table.functions.key(key)
    end
end