function createMeteorite(id,world, diff)
    local exists = true
    local id = id or Element.id
    local type = Element.type.METEORITE
    local functions = functions or {
        draw = function (self)
            if (self.exists) then
                love.graphics.setColor({1,1,1,1})
                love.graphics.draw(self.img,self.dimensions.x,self.dimensions.y,self.dimensions.rot,self.dimensions.w,self.dimensions.h,self.img:getPixelWidth()/2,self.img:getPixelHeight()/2)                
            end
        end,
        update = function (self,dt)
            if (self.exists) then
                self.dimensions.x,self.dimensions.y = self.collider:getX(),self.collider:getY()
                self.dimensions.rot = self.collider:getAngle()
                
                if (self.dimensions.x + self.dimensions.w * self.img:getPixelWidth() < 0 or self.dimensions.x > main.dimensions.w or self.dimensions.y > main.dimensions.h + 100) then
                    self.exists = false
                    self.collider:destroy()
                    gameTable.removeElement(self)
                end

                if (self.hp <= 0) then
                    self.hp = 0
                    self.exists = false
                    self.collider:destroy()
                    gameTable.removeElement(self)
                    gameTable.score = gameTable.score + 1
                end
            end
        end,
        setHp = function(self,hp)
            self.hp = hp
        end,
        getHp = function (self)
            return self.hp
        end
    }
    local img = img or main.images.meteor
    local dimensions = dimensions or {
        x = 0,
        y = math.random(-200,-600),
        rot = 0,
        w = 0.3 * main.dimensions.drawScaleX,
        h = 0.3 * main.dimensions.drawScaleX,
    }
    dimensions.x = math.random(0, main.dimensions.w - (dimensions.w*img:getPixelWidth()))

    local collider = world:newRectangleCollider(dimensions.x, dimensions. y, dimensions.w * img:getPixelWidth(), dimensions.h * img:getPixelHeight())
    collider:setType("dynamic")
    collider:applyForce(0,200000)

    local hp = 1 * diff

    local result = {
        id = id,
        type = type,
        functions = functions,
        img = img,
        dimensions = dimensions,
        collider = collider,
        exists = exists,
        hp = hp,
    }

    collider:setUserData(result)
    

    return result
       
end