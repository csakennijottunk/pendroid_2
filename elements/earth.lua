function createEarth(id,world)
    local id = id or Element.id
    local type = Element.type.EARTH
    local functions = functions or {
        draw = function (self)
            love.graphics.setColor({1,1,1,1})
            love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h,self.img:getPixelWidth()/2,self.img:getPixelHeight()/2)
        end,
        update = function (self,dt)
            self.dimensions.x,self.dimensions.y = self.collider:getPosition()
        end
    }
    local img = img or main.images.earth
    local dimensions = dimensions or {
        x = 0,
        y = main.dimensions.h*0.8,
        rot = 0,
        w = 0.1*main.dimensions.drawScaleX,
        h = 0.1*main.dimensions.drawScaleX,
    }
    dimensions.x = (main.dimensions.w - img:getPixelWidth()*dimensions.w)/2
    local collider = world:newCircleCollider(dimensions.x + dimensions.w * img:getPixelWidth()/2, dimensions.y + dimensions.w * img:getPixelWidth()/2, dimensions.w * img:getPixelWidth()/2.4)
    collider:setType("static")
    local result = {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions,
        collider = collider,
    }
    collider:setUserData(result)

    return result
       
end