-- https://github.com/danielga/gm_stringtable
if not pcall( require, "stringtable" ) or (stringtable == nil) then
    MsgN( "Please install binnary module: https://github.com/danielga/gm_stringtable" )
    return
end

local function info( str )
    MsgN( "[stringtable] " .. str )
end

function stringtable.GetAll()
    local tables = {}
    for i = 0, stringtable.GetCount() - 1 do
        tables[ i ] = stringtable.Get( i )
    end

    return tables
end

function stringtable.DestroyEmptyStrings( data )
    if (data) then
        local strings = data:GetStrings()
        data:Lock( true )
        data:DeleteAllStrings()

        for num = 0, #strings do
            local str = strings[ num ]
            if (str == nil) then continue end
            if (str:match( "[^%s]" ) == nil) then continue end
            data:AddString( true, str )
        end

        data:Lock( false )
    end
end

function stringtable.GetStrings( name )
    assert( isstring( name ), "String table name must be a string!" )

    local data = stringtable.Find( name )
    if (data) then
        return data:GetStrings()
    end
end

function stringtable.AddTo( name, key, str )
    assert( isstring( name ), "String table name must be a string!" )
    if isstring( key ) then
        if not isstring( str ) then
            str = tostring( str )
        end

        if (str) then
            local data = stringtable.Find( name )
            if (data) then
                data:Lock( true )
                data:AddString( true, str )
                data:Lock( false )

                stringtable.DestroyEmptyStrings( data )
            end
        end
    end
end

function stringtable.RemoveFrom( name, key, print_info )
    assert( isstring( name ), "String table name must be a string!" )

    if isstring( key ) then
        local data = stringtable.Find( name )
        if (data) then
            local strings = data:GetStrings()
            if (strings) then
                if (table.Count( strings ) < 1) then return end
                data:Lock( true )
                data:DeleteAllStrings()

                for num = 0, #strings do
                    local str = strings[ num ]
                    if (str == nil) then continue end
                    if str:match( key ) then
                        if (print_info == true) then
                            info( "Removed `" .. str .. "` from `" .. name .. "`" )
                        end

                        continue
                    end

                    if (str:match( "[^%s]" ) == nil) then
                        if (print_info == true) then
                            info( "Removed empty `" .. str .. "` from `" .. name .. "`" )
                        end

                        continue
                    end

                    data:AddString( true, str )
                end

                data:Lock( false )
            end
        end
    end
end

function stringtable.Clear( name )
    assert( isstring( name ), "String table name must be a string!" )
    local data = stringtable.Find( name )
    if (data) then
        data:Lock( true )
        data:DeleteAllStrings()
        data:Lock( false )
    end
end

-- Network Strings
function util.GetNetworkStrings()
    return stringtable.GetStrings( "networkstring" )
end

function util.ClearNetworkStrings()
    stringtable.Clear( "networkstring" )
end

function util.RemoveNetworkString( str )
    if isstring( str ) then
        stringtable.RemoveFrom( "networkstring", str, true )
    end
end

-- CSLuaFiles
function GetCSLuaFiles()
    return stringtable.GetStrings( "client_lua_files" )
end

function ClearCSLuaFiles()
    stringtable.Clear( "client_lua_files" )
    info( "Warning: All cs lua files list cleanuped!" )
end

function RemoveCSLuaFile( path )
    if isstring( path ) then
        info( "Remove from `client_lua_files`: " .. path )
        stringtable.RemoveFrom( "client_lua_files", path, true )
    end
end

-- PrecacheModels
function util.GetPrecacheModels()
    return stringtable.GetStrings( "modelprecache" )
end

function util.ClearPrecacheModels()
    info( "Models cache is empty now!" )
    stringtable.Clear( "modelprecache" )
end

-- PrecacheSounds
function util.GetPrecacheSounds()
    return stringtable.GetStrings( "soundprecache" )
end

function util.ClearPrecacheSounds()
    info( "Sound cache is empty now!" )
    stringtable.Clear( "soundprecache" )
end

-- PrecacheDecals
function util.GetPrecacheDecals()
    return stringtable.GetStrings( "decalprecache" )
end

function util.ClearPrecacheDecals()
    info( "Decals cache is empty now!" )
    stringtable.Clear( "decalprecache" )
end

-- PrecacheGeneric
function util.GetPrecacheGeneric()
    return stringtable.GetStrings( "genericprecache" )
end

-- ParticleEffectNames
function util.GetParticleEffectNames()
    return stringtable.GetStrings( "ParticleEffectNames" )
end

-- LightStyles
function util.GetLightStyles()
    return stringtable.GetStrings( "lightstyles" )
end
