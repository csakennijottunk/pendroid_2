function createAmmo(id,world,analog)
    local id = id or Element.id
    local type = Element.type.AMMO
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
    local img = img or main.images.badlogic
    local dimensions = dimensions or {
        x = 0 ,
        y = main.dimensions.h*0.8,
        rot = 0,
        w = 0.1*main.dimensions.drawScaleX,
        h = 0.1*main.dimensions.drawScaleX,
    }
    dimensions.x = main.dimensions.w/2 - ((dimensions.w * img:getPixelWidth())/2)

    local collider = world:newRectangleCollider(dimensions.x, dimensions. y, dimensions.w * img:getPixelWidth(), dimensions.h * img:getPixelHeight())
    collider:setType("dynamic")
    collider:applyForce(analog.getX()*200000,analog.getY()*200000)

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