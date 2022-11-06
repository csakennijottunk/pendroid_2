function createShootButton(id)
    local id = id or Element.id
    local type = Element.type.SHOOT_BUTTON
    local functions = functions or {
        draw = function (self)
            love.graphics.setColor({1,1,1,1})
            love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h)
        end,
        update = function (self,dt)
        end,
        click = function (self)
            print("szar")
        end
    }
    local img = img or main.images.badlogic
    local dimensions = dimensions or {
        x = 50,
        y = 0,
        rot = 0,
        w = 0.7 * main.dimensions.drawScaleX,
        h = 0.4 * main.dimensions.drawScaleX,
    }
    dimensions.y = main.dimensions.h - (img:getPixelWidth() * dimensions.h) - 50
    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions
    }
end