

gameTable = {
    timer = {
        dValue = 5,
        value = 5,
    },
    functions = {
        setup = function ()
            require("star")
            require("Framework.andralog")
            Analog = newAnalog(main.dimensions.w - main.dimensions.w/10,main.dimensions.h - main.dimensions.w/10,main.dimensions.w/12,(main.dimensions.w/12)/3,1)
            --#region template_data
            Element = {
                id = "Actor1",
                type = {
                    AMMO = "AMMO",
                    METEORITE = "METEORITE",
                    ASTRONAUT = "ASTRONAUT",
                    STAR = "STAR",
                },                
            }
            --#endregion
            --#region Föld
            for i = 1, 100 do
                --table.insert(gameTable.elements, gameTable.createElement(1, Element.type.STAR))                
                table.insert(gameTable.elements, createStar(i)) 
            end
            table.insert(gameTable.elements, gameTable.createElement(1, Element.type.EARTH))                
            --#endregion
            tachanka = {
                w = 0.1*main.dimensions.drawScaleX,
                h = 0.1*main.dimensions.drawScaleX,
                x = main.dimensions.w / 2 - 30,
                y = main.dimensions.h - 150,
                rot = 0,
                img = love.graphics.newImage("assets/badlogic.jpg"),
                correctPos = false,
            }
            crosshair = {
                w = 0.1*main.dimensions.drawScaleX,
                h = 0.1*main.dimensions.drawScaleX,
                x = 30,
                y = 50,
                rot = 0,
                img = love.graphics.newImage("assets/badlogic.jpg"),
                correctPos = false,
            }
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
    print(analogpos)
    gameTable.timer.value = gameTable.timer.value - dt
    if (gameTable.timer.value < 0) then
        table.insert(gameTable.elements,gameTable.createElement(#gameTable.elements,Element.type.METEORITE))
        gameTable.timer.value = gameTable.timer.dValue
    end
    for i,v in pairs(gameTable.elements) do
        --[[
        if (gameTable.checkCollision(v.dimensions.x,v.dimensions.y,v.dimensions.w*v.img:getPixelWidth(),v.dimensions.h*v.img:getPixelHeight(),earth.x,earth.y,earth.w * earth.img:getPixelWidth(),earth.h*earth.img:getPixelHeight())) then
            local el = gameTable.getElementIndex(v.id)
            table.remove(gameTable.elements,el)
        end
        ]]--
        v.functions.update(v,dt)    
    end
end

function gameTable.functions.draw()
    love.graphics.draw(tachanka.img,tachanka.x,tachanka.y,tachanka.rot,tachanka.w,tachanka.h)
    --love.graphics.draw(crosshair.img,crosshair.x,crosshair.y,crosshair.rot,crosshair.w,crosshair.h)
    --#region föld kirajzolása
    --gameTable.drawEarth()
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
    analogpos = Analog.touchMoved(id, x, y, dx, dy, pressure)
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
    --[[
    if (type == Element.type.STAR) then        
        functions = functions or {
            draw = function (self)
                love.graphics.setColor({1,1,1,1})
                love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h)
            end,
            update = function (self,dt)
                self.dimensions.x = self.dimensions.x + self.dimensions.r * dt * 10
                if self.dimensions.x > main.dimensions.w then
                    self.dimensions.x = -self.dimensions.w * self.img:getPixelWidth()
                    self.dimensions.y = math.random(0, main.dimensions.h)
                end

            end
        }
        img = img or love.graphics.newImage("assets/badlogic.jpg")
        dimensions = dimensions or {
            r = math.random(1,6),
            x = math.random(0, main.dimensions.w),
            y = math.random(0, main.dimensions.h),
            rot = 0,
            w = 0.1 * main.dimensions.drawScaleX,
            h = 0.1 * main.dimensions.drawScaleX,
        }
        dimensions.w = dimensions.w * dimensions.r / 10
        dimensions.h = dimensions.h * dimensions.r / 10
    end 
    ]]   
    if (type == Element.type.EARTH) then        
        functions = functions or {
            draw = function (self)
                love.graphics.setColor({1,1,1,1})
                love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h)
            end,
            update = function (self,dt)
            end
        }        
        img = img or love.graphics.newImage("assets/earth.png")
        dimensions = dimensions or {
            x = 0,
            y = main.dimensions.h*0.8,
            rot = 0,
            w = 0.1*main.dimensions.drawScaleX,
            h = 0.1*main.dimensions.drawScaleX,
            correctPos = false,
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