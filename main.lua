ModuleManager = require( "libs/modulemanager" )
ModuleManager:Register( "libs/*" )
ModuleManager:Register( "lua/*" )

function love.load()
    ModuleManager:Call( "init" )

    love.graphics.setDefaultFilter( "nearest" )
end

function love.update( dt )
    ModuleManager:Call( "update", dt )
end

function love.draw()
    ModuleManager:Call( "draw" )
end