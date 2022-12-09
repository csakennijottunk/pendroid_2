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
    local img = img or main.images.weapon
    local dimensions = dimensions or {
        x = 0,
        y = main.dimensions.h*0.8,
        rot = math.rad(-90),
        w = 0.6*main.dimensions.drawScaleX,
        h = 0.6*main.dimensions.drawScaleX,
    }
    dimensions.x = main.dimensions.w/2 - 12.5

    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions
    }
       
end