function createAmmoIndicator(id)
    local id = id or Element.id
    local type = Element.type.AMMO_INDICATOR
    local functions = functions or {
        draw = function (self)
            if (Analog.isHeld()) then
                love.graphics.setColor({1,1,1,1})
                love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h,self.img:getPixelWidth()/2,self.img:getPixelHeight())
            end
        end,
        update = function (self,dt,rot)
            self.dimensions.rot = 90+rot
        end
    }
    local img = img or main.images.ammo_indicator
    local dimensions = dimensions or {
        x = 0 ,
        y = 0,
        rot = 0,
        w = 0.5,
        h = 0.5,
    }
    dimensions.h = getElementByType(Element.type.EARTH).dimensions.y / img:getPixelHeight()
    dimensions.x = main.dimensions.w/2
    dimensions.y = img:getPixelHeight() * dimensions.h

    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions
    }
       
end