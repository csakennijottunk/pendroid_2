function createMeteorite(id)
    local id = id or Element.id
    local type = Element.type.METEORITE
    local functions = functions or {
        draw = function (self)
            love.graphics.setColor({1,1,1,1})
            love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h)
        end,
        update = function (self,dt)
            self.dimensions.y = self.dimensions.y + 2
        end
    }
    local img = img or love.graphics.newImage("assets/badlogic.jpg")
    local dimensions = dimensions or {
        x = math.random(0,main.dimensions.w-(0.5 * main.dimensions.drawScaleX)*img:getPixelWidth()),
        y = math.random(-200,-600),
        rot = 0,
        w = 0.3 * main.dimensions.drawScaleX,
        h = 0.3 * main.dimensions.drawScaleX,X,
    }

    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions
    }
       
end