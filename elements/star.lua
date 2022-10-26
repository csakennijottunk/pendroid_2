function createStar(id)
    local id = id or Element.id
    local type = Element.type.STAR
    local functions = functions or {
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
    local img = img or love.graphics.newImage("assets/kantsal.png")
    local dimensions = dimensions or {
        r = math.random(1,6),
        x = math.random(0, main.dimensions.w),
        y = math.random(0, main.dimensions.h),
        rot = 0,
        w = 0.1 * main.dimensions.drawScaleX,
        h = 0.1 * main.dimensions.drawScaleX,
    }
    dimensions.w = dimensions.w * dimensions.r / 15
    dimensions.h = dimensions.h * dimensions.r / 15

    return {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions
    }
end