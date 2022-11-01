

gameTable = {
    timer = {
        dValue = 0.2,
        value = 0.2,
    },
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
                    AMMO_INDICATOR = "AMMO_INDICATOR"
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

            self.buttons = {
                shootButton = {
                    x = 25 * main.dimensions.drawScaleX,
                    y = main.dimensions.h, 
                    w = main.dimensions.w/7,
                    h = (main.dimensions.w/5)/3,
                    name = "SHOOT",
                    click = function ()
                        if (Analog.getX() ~= 0 or Analog.getY() ~= 0) then
                            table.insert(self.elements,createAmmo(#self.elements,self.world,Analog))
                            
                        end
                    end,
                }
            }
            self.buttons.shootButton.y = self.buttons.shootButton.y - self.buttons.shootButton.h - (main.dimensions.drawScaleX*25)


            end
            
        end,
        update = nil,
        draw = nil,
        click = nil,
        clickRelease = nil,
        drawJoyStick = nil,
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
        --[[
        if (gameTable.checkCollision(v.dimensions.x,v.dimensions.y,v.dimensions.w*v.img:getPixelWidth(),v.dimensions.h*v.img:getPixelHeight(),earth.x,earth.y,earth.w * earth.img:getPixelWidth(),earth.h*earth.img:getPixelHeight())) then
            local el = gameTable.getElementIndex(v.id)
            table.remove(gameTable.elements,el)
        end
        ]]--
        local rot = -(math.rad(25) + Analog.getAngle(Analog.dx,Analog.dy,Analog.getX()*100,Analog.getY()*100))     
        v.functions.update(v,dt,rot)
    end
end

function gameTable.functions.draw()
    --love.graphics.draw(crosshair.img,crosshair.x,crosshair.y,crosshair.rot,crosshair.w,crosshair.h)
    --#region föld kirajzolása
    --gameTable.drawEarth()
    --#endregion
    --#region joystick
    --#endregion
    --gameTable.world:draw()
    
    for i, v in pairs(gameTable.elements) do
        v.functions.draw(v)
    end
    Analog.draw()
    --@todo BEFEJEZNI A MINIGUN IRÁNYÁT MUTATO IMG_T
end

function gameTable.functions.touchpressed(id, x, y, dx, dy, pressure)
    if (not Analog.isHeld()) then
        Analog = newAnalog(x,y,70,21)        
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