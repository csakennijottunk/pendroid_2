gamefont = love.graphics.newFont("assets/heavy_heap_rg.otf", 30)
gameTable = {
    timer = {
        dValue = 2,
        value = 2,
    },
    gameTimer = {
        value = 15,
    },
    score = 0,
    functions = {
        setup = function (self)
            if (self) then
                self.text = {
                    scorelabel = {
                        text = love.graphics.newText(gamefont, "Your score: " .. self.score),
                        x = 0,
                        y = 0,
                    },
                    time = {
                        text = love.graphics.newText(gamefont, "Remaining time: " .. self.gameTimer.value .. "sec"),
                        x = main.dimensions.w - 250,
                        y = 0,
                    },
                    planethp = {
                        text = love.graphics.newText(gamefont, gameTable.planet_hp),
                        x = main.dimensions.w - 500,
                        y = 0,
                    }
                }

                --print(mapselectorTable.dif .. '\t' .. mapselectorTable.map)
                self.difficulty = mapselectorTable.dif
                self.map = mapselectorTable.map
                if (self.map == 1) then
                    self.map_path = main.images.earth
                elseif (self.map == 2) then
                    self.map_path = main.images.mars
                elseif (self.map == 3) then
                    self.map_path = main.images.saturn
                end
                self.gameTimer.value = 15
                self.timer.dValue = 2
                self.timer.dValue = self.timer.dValue / self.difficulty
                self.elements = {}
                self.world = wf.newWorld(0,0,true)
                self.world:setCallbacks(self.functions.beginContact, self.functions.endContact)
                self.planet_hp = 6 - self.difficulty
                self.gameTimer.value = self.gameTimer.value * self.difficulty
                self.gamestate = nil
            --#region Element requires
            require("elements.star")
            require("elements.earth")
            require("elements.meteorite")
            require("elements.gun")
            require("elements.ammo")
            require("elements.ammo_indicator")
            require("elements.shootButton")
            --#endregion
            --#region analog requires
            require("Framework.andralog")
            --#endregion
            Analog = newAnalog(main.dimensions.w - main.dimensions.w/5,main.dimensions.h - main.dimensions.w/8,70,21)
            analogDimensions = {
                x = main.dimensions.w - main.dimensions.w/10,
                y = main.dimensions.h - main.dimensions.w/10,
            }
            --#region template_data
            Element = {
                id = "Actor1",
                type = {
                    AMMO = "AMMO",
                    METEORITE = "METEORITE",
                    ASTRONAUT = "ASTRONAUT",
                    STAR = "STAR",
                    GUN = "GUN",
                    AMMO_INDICATOR = "AMMO_INDICATOR",
                    SHOOT_BUTTON = "SHOOT_BUTTON"
                },                
            }
            
            --#endregion
            --#region Föld
            for i = 1, 100 do
                --table.insert(gameTable.elements, gameTable.createElement(1, Element.type.STAR))                
                table.insert(gameTable.elements, createStar(#gameTable.elements)) 
            end
            table.insert(gameTable.elements, createEarth(#gameTable.elements,self.world,self.map_path))                
            --#endregion
            --#region gun
            table.insert(gameTable.elements,createGun(#gameTable.elements))
            --#endregion
            --#region
            table.insert(gameTable.elements,createAmmoIndicator(#gameTable.elements))  

            table.insert(gameTable.elements,createShootButton(#gameTable.elements))
            end
            
        end,
        update = nil,
        draw = nil,
        mousepressed = nil,
        beginContact = nil,
        endContact = nil,
        getElementByIndex = nil,
    },
    elements = {},
}
function gameTable.functions.update(dt)
    gameTable.world:update(dt)
    Analog.update(dt)
    gameTable.timer.value = gameTable.timer.value - dt
    gameTable.text.planethp.text:set("Remaining health: " .. gameTable.planet_hp)
    gameTable.text.time.text:set("Remaining time: " .. math.ceil(gameTable.gameTimer.value) .. "sec")
    gameTable.text.scorelabel.text:set("Your score: " .. gameTable.score)
    gameTable.gameTimer.value = gameTable.gameTimer.value - dt
    print(gameTable.gameTimer.value)
    if (gameTable.timer.value < 0) then
        table.insert(gameTable.elements,createMeteorite(#gameTable.elements,gameTable.world,gameTable.difficulty))
        gameTable.timer.value = gameTable.timer.dValue

    end
    if (gameTable.gameTimer.value <= 0 or gameTable.planet_hp <= 0) then
        for i, v in pairs(gameTable.elements) do
            if (v.collider) then
                v.collider:destroy()
            end
            gameTable.removeElement(v)
        end
        if (gameTable.planet_hp <= 0) then
            gameTable.gamestate = false         
        else
            gameTable.gamestate = true
        end
        main.setScreen(main.screens.gamend)
    end
    for i,v in pairs(gameTable.elements) do
        local rot = -(math.rad(26) + Analog.getAngle(Analog.dx,Analog.dy,Analog.getX()*100,Analog.getY()*100))  
        v.functions.update(v,dt,rot)
    end
end
function gameTable.functions.draw()
    for i,v in pairs(gameTable.text)do
        love.graphics.draw(v.text, v.x, v.y)
    end
    for i, v in pairs(gameTable.elements) do
        v.functions.draw(v)
    end
    Analog.draw()
end

function gameTable.functions.touchpressed(id, x, y, dx, dy, pressure)
    local shootButton = getElementByType(Element.type.SHOOT_BUTTON)
    if (not Analog.isHeld()) then
        --#TODO CSAK AKKOR CSERELJUK KI AZ ANALOG POZICIOJAT HA NEM A SHOOTBUTTON_RE NYOM!!!!
        if (not isInBox(x,y,shootButton.dimensions.x,shootButton.dimensions.y,shootButton.dimensions.w * shootButton.img:getPixelWidth(),shootButton.dimensions.h* shootButton.img:getPixelHeight())) then
            Analog.cx,Analog.cy = x,y    
        end
    elseif (isInBox(x,y,shootButton.dimensions.x,shootButton.dimensions.y,shootButton.dimensions.w * shootButton.img:getPixelWidth(),shootButton.dimensions.h* shootButton.img:getPixelHeight())) then
        table.insert(gameTable.elements,createAmmo(#gameTable.elements,gameTable.world,Analog))
    end
    Analog.touchPressed(id, x, y, dx, dy, pressure)
end


function gameTable.functions.touchreleased(id, x, y, dx, dy, pressure)
    Analog.touchReleased(id, x, y, dx, dy, pressure)
end

function gameTable.functions.touchmoved(id, x, y, dx, dy, pressure)
    Analog.touchMoved(id, x, y, dx, dy, pressure)
end

function gameTable.createElement(id,type,img,functions,dimensions)
    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions
    }
end

function gameTable.getElement(id)
    for i,v in pairs(gameTable.elements) do
        if (v.id == id) then
            return v
        end
    end
    return nil
end

function getElementByType(type)
    for i,v in pairs(gameTable.elements) do
        if (v.type == type) then
            return v
        end
    end
    return nil
end

function gameTable.getElementIndex(id)
    for i,v in pairs(gameTable.elements) do
        if (v.id == id) then
            return i
        end
    end
    return nil
end
function gameTable.getElementByIndex(element)
    -- table.remove(gameTable.elements, self)
    for key, value in pairs(gameTable.elements) do
        if value == element then
            return key
        end
    end
end

function gameTable.removeElement(element)
    -- table.remove(gameTable.elements, self)
    table.remove(gameTable.elements, gameTable.getElementByIndex(element))
end

function gameTable.checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end


function angle_between_points(analog,turret)
    targetX,targetY = analog.x,analog.y
    gunX,gunY = turret.x,turret.y
    myradians = math.atan((gunY-targetY), (targetX-gunX))
    degrees = math.deg(myradians)
    return degrees
end

function isInBox(cx,cy,x,y,width,height)
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then 
        return true 
    else 
        return false 
    end 
end


function gameTable.functions.beginContact(a,b,coll)
    local o1 = a:getUserData()
    local o2 = b:getUserData()
    if (o1.type == Element.type.METEORITE and o2.type == Element.type.AMMO) then
        --a:getBody():destroy()
        --gameTable.removeElement(o1)
        o2.collider:destroy()
        gameTable.removeElement(o2)
        o1.functions.setHp(o1,o1.functions.getHp(o1) - 1)
        --gameTable.score = gameTable.score + 1

    elseif (o1.type == Element.type.AMMO and o2.type == Element.type.METEORITE) then
        o2.functions.setHp(o2,o2.functions.getHp(o2) - 1)
        o1.collider:destroy()
        gameTable.removeElement(o1)
        --gameTable.score = gameTable.score + 1
    elseif (o1.type == Element.type.METEORITE and o2.type == Element.type.EARTH) then
        o1.functions.setHp(o1,o1.functions.getHp(o1)-1)
        gameTable.planet_hp = gameTable.planet_hp-1
    elseif (o1.type == Element.type.EARTH and o2.type == Element.type.METEORITE)  then
        o2.functions.setHp(o2,o2.functions.getHp(o2)-1)
        gameTable.planet_hp = gameTable.planet_hp - 1
    end
end

function gameTable.functions.endContact(a,b,coll)
    
end