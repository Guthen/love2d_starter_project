--  > ModuleManager Manager: by Guthen

local ModuleManager = {}

local modules = {}
local num_modules = {}

function ModuleManager:Register( name, path )
    if not path then
        path = name
    end

    if path:find( "/%*" ) then
        path = path:match( "[%w/]+" ) or ""
        for i, v in ipairs( love.filesystem.getDirectoryItems( path ) ) do
            if v:find( ".lua" ) then
                local name = v:gsub( ".lua", "" )

                num_modules[#num_modules + 1] = require( path .. name )
                modules[name] = num_modules[#num_modules]
            end
        end
        return
    end

    num_modules[#num_modules + 1] = require( path )
    modules[name] = num_modules[#num_modules]

    return modules[name]
end

function ModuleManager:Get( name )
    return modules[name]
end

function ModuleManager:Call( key, ... )
    for i, v in ipairs( num_modules ) do
        if type( v[key] ) == "function" then 
            v[key]( v, ... ) 
        end
    end
end

return ModuleManager