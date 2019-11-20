local Image = {}
local images = {}

function Image:init()
    self:Register( "img/*" )
end

function Image:Register( path )
    if path:find( "/%*" ) then
        path = path:match( "[%w/]+" ) or ""
        for i, v in ipairs( love.filesystem.getDirectoryItems( path ) ) do
            if v:find( ".png" ) then
                images[v] = love.graphics.newImage( path .. v )
            elseif love.filesystem.getInfo( path .. v ).type == "directory" then 
                self:Register( path .. v .. "/*" )
            end
        end
        return
    end

    images[#images + 1] = love.graphics.newImage( path )
end

return Image