gameTable = {
    timer = {
        dValue = 5,
        value = 5,
    },
    functions = {
        setup = function ()
            require("Framework.andralog")
            Analog = newAnalog(main.dimensions.w - main.dimensions.w/10,main.dimensions.h - main.dimensions.w/10,main.dimensions.w/12,(main.dimensions.w/12)/3,1)
            --#region template_data
            Element = {
                id = "Actor1",
                type = {
                    AMMO = "AMMO",
                    METEORITE = "METEORITE",
                    ASTRONAUT = "ASTRONAUT",
                },
            }
            --#endregion
            --#region Föld
            earth = {
                x = 0,
                y = main.dimensions.h*0.8,
                rot = 0,
                w = 0.1*main.dimensions.drawScaleX,
                h = 0.1*main.dimensions.drawScaleX,
                img = love.graphics.newImage("assets/earth.png"),
                correctPos = false,
            }
            --#endregion
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
    Analog.update(dt)
    gameTable.timer.value = gameTable.timer.value - dt
    if (gameTable.timer.value < 0) then
        table.insert(gameTable.elements,gameTable.createElement(#gameTable.elements,Element.type.METEORITE))
        gameTable.timer.value = gameTable.timer.dValue
    end
    for i,v in pairs(gameTable.elements) do
        if (gameTable.checkCollision(v.dimensions.x,v.dimensions.y,v.dimensions.w*v.img:getPixelWidth(),v.dimensions.h*v.img:getPixelHeight(),earth.x,earth.y,earth.w * earth.img:getPixelWidth(),earth.h*earth.img:getPixelHeight())) then
            local el = gameTable.getElementIndex(v.id)
            table.remove(gameTable.elements,el)
        end
        v.functions.update(v,dt)    
    end
end

function gameTable.functions.draw()
    --#region föld kirajzolása
    gameTable.drawEarth()
    --#endregion
    --#region joystick
    Analog.draw()
    --#endregion
    for i, v in pairs(gameTable.elements) do
        v.functions.draw(v)
    end
end

function gameTable.functions.touchpressed(id, x, y, dx, dy, pressure)
    Analog.touchPressed(id, x, y, dx, dy, pressure)
end

function gameTable.functions.touchreleased(id, x, y, dx, dy, pressure)
    Analog.touchReleased(id, x, y, dx, dy, pressure)
end

function gameTable.functions.touchmoved(id, x, y, dx, dy, pressure)
    Analog.touchMoved(id, x, y, dx, dy, pressure)
end

function gameTable.createElement(id,type,img,functions,dimensions)
    id = id or Element.id
    type = type
    if (type == Element.type.METEORITE) then
        functions = functions or {
            draw = function (self)
                love.graphics.setColor({1,1,1,1})
                love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h)
            end,
            update = function (self,dt)
                self.dimensions.y = self.dimensions.y + 2
            end
        }
        img = img or love.graphics.newImage("assets/badlogic.jpg")
        dimensions = dimensions or {
            x = math.random(0,main.dimensions.w-(0.5 * main.dimensions.drawScaleX)*img:getPixelWidth()),
            y = math.random(-200,-600),
            rot = 0,
            w = 0.3 * main.dimensions.drawScaleX,
            h = 0.3 * main.dimensions.drawScaleX,
        }
    end
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

function gameTable.getElementIndex(id)
    for i,v in pairs(gameTable.elements) do
        if (v.id == id) then
            return i
        end
    end
    return nil
end

function gameTable.drawEarth()
    if (earth.correctPos == false) then
        earth.x = (main.dimensions.w - earth.img:getPixelWidth()*earth.w)/2
        earth.correctPos = true
    end
    love.graphics.draw(earth.img,earth.x,earth.y,earth.rot,earth.w,earth.h)
end

function gameTable.checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end