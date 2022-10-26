function createMeteorite(id,world)
    local id = id or Element.id
    local type = Element.type.METEORITE
    local functions = functions or {
        draw = function (self)
            love.graphics.setColor({1,1,1,1})
            love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h,self.img:getPixelWidth()/2,self.img:getPixelHeight()/2)
        end,
        update = function (self,dt)
            self.dimensions.x,self.dimensions.y = self.collider:getX(),self.collider:getY()
            self.dimensions.rot = self.collider:getAngle()
        end
    }
    local img = img or love.graphics.newImage("assets/badlogic.jpg")
    local dimensions = dimensions or {
        x = main.dimensions.w/2,
        y = math.random(-200,-600),
        rot = 0,
        w = 0.3 * main.dimensions.drawScaleX,
        h = 0.3 * main.dimensions.drawScaleX,
    }

    local collider = world:newRectangleCollider(dimensions.x, dimensions. y, dimensions.w * img:getPixelWidth(), dimensions.h * img:getPixelHeight())
    collider:setType("dynamic")
    collider:applyForce(0,200000)
    

    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions,
        collider = collider,
    }
       
end