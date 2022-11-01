function createGun(id)
    local id = id or Element.id
    local type = Element.type.GUN
    local functions = functions or {
        draw = function (self)
            love.graphics.setColor({1,1,1,1})
            love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h)
        end,
        update = function (self,dt)
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

    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions
    }
       
end