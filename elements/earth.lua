function createEarth(id,world)
    local id = id or Element.id
    local type = Element.type.EARTH
    local functions = functions or {
        draw = function (self)
            love.graphics.setColor({1,1,1,1})
            love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h)
        end,
        update = function (self,dt)
        end
    }
    local img = img or love.graphics.newImage("assets/earth.png")
    local dimensions = dimensions or {
        x = 0,
        y = main.dimensions.h*0.8,
        rot = 0,
        w = 0.1*main.dimensions.drawScaleX,
        h = 0.1*main.dimensions.drawScaleX,
    }
    dimensions.x = (main.dimensions.w - img:getPixelWidth()*dimensions.w)/2
    local collider = world:newRectangleCollider(dimensions.x, dimensions. y, dimensions.w * img:getPixelWidth(), dimensions.h * img:getPixelHeight())
    collider:setType("static")

    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions
    }
       
end