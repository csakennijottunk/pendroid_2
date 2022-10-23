require("game")
main = {
    dimensions = {},
    setScreen = nil,
    currentScreen = nil,
    previousScreen = nil,
    screens = {
        game = {
            table = gameTable,
        },
    },
}
function love.load()
    --Betöltjük az összes képernyőnek az inicializáló metódusát.
    for i,v in pairs(main.screens) do
        v.table.functions.setup()
    end
    main.setScreen(main.screens.game)
    main.dimensions.w,main.dimensions.h = love.graphics.getDimensions()
    main.dimensions.aw,main.dimensions.ah = 360,480
end

function love.update(dt)
    print(main.currentScreen.table.functions.update)
    if (main.currentScreen ~= nil and main.currentScreen.table.functions.update~= nil) then
        main.currentScreen.table.functions.update(dt)
    end
end

function love.draw()
    love.graphics.scale(main.dimensions.w/main.dimensions.aw,main.dimensions.h/main.dimensions.ah)
    if (main.currentScreen ~= nil and main.currentScreen.table.functions.draw~= nil) then
        main.currentScreen.table.functions.draw()
    end
end

function main.setScreen(screen)
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