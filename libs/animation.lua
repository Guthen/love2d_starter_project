local Animation = {}
local anims

function Animation:new( img, fps, loop )
    local anim = {}
        anim.img = type( img ) == "userdata" and img or love.graphics.newImage( img )
        anim.fps = fps or 1
        anim.time = 0
        anim.cur_quad = 1
        anim.loop = loop or true
        anim.quads = {}
        anim.draw = function( self, x, y, w, h, ang, center )
            local ih = self.img:getHeight()
            love.graphics.draw( self.img, self.quads[self.cur_quad], x, y, ang, w / ih, h / ih, center and ih / 2 or 0, center and ih / 2 or 0 )
        end

    local w, h = anim.img:getDimensions()
    for x = 0, w, h do
        anim.quads[#anim.quads + 1] = love.graphics.newQuad( x, 0, h, h, w, h )
    end

    anims[#anims + 1] = anim
    return anim
end

function Animation:init()
    anims = {}
end

function Animation:update( dt )
    for i, v in ipairs( anims ) do
        v.time = v.time + dt
        if v.time >= v.fps then
            v.time = 0

            local last_quad = v.cur_quad
            v.cur_quad = ( v.cur_quad + 1 ) % #v.quads
            if v.cur_quad == 0 then v.cur_quad = 1 end

            if not v.loop and last_quad > v.cur_quad then
                anims[i] = nil
            end
        end
    end
end

setmetatable( Animation, { 
        __call = function( self, ... ) 
            return self:new( ... )
        end
    } )

return Animation