

gameTable = {
    timer = {
        dValue = 0.2,
        value = 0.2,
    },
    score = 0,
    functions = {
        setup = function (self)
            if (self) then
                self.elements = {}
                self.world = wf.newWorld(0,0,true)
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
            table.insert(gameTable.elements, createEarth(#gameTable.elements,self.world))                
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
    },
    elements = {},
}
function gameTable.functions.update(dt)
    gameTable.world:update(dt)
    Analog.update(dt)
    gameTable.timer.value = gameTable.timer.value - dt
    if (gameTable.timer.value < 0) then
        table.insert(gameTable.elements,createMeteorite(#gameTable.elements,gameTable.world))
        gameTable.timer.value = gameTable.timer.dValue
    end
    for i,v in pairs(gameTable.elements) do
        local rot = -(math.rad(26) + Analog.getAngle(Analog.dx,Analog.dy,Analog.getX()*100,Analog.getY()*100))  
        v.functions.update(v,dt,rot)
    end
    gameTable.score = gameTable.score + 1
end
function gameTable.functions.draw()
    
    for i, v in pairs(gameTable.elements) do
        v.functions.draw(v)
    end
    Analog.draw()
    love.graphics.print("A találatok száma: " .. gameTable.score)
end


function gameTable.functions.touchpressed(id, x, y, dx, dy, pressure)
    local shootButton = getElementByType(Element.type.SHOOT_BUTTON)
    if (not Analog.isHeld()) then
        Analog = newAnalog(x,y,70,21)   
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