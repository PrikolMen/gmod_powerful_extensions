-- https://github.com/danielga/gm_stringtable
if not pcall( require, "stringtable" ) or (stringtable == nil) then
    MsgN( "Please install binnary module: https://github.com/danielga/gm_stringtable" )
    return
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

function stringtable.RemoveFrom( name, key )
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
                    if (str == key) then continue end
                    if (str:match( "[^%s]" ) == nil) then continue end
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
        stringtable.RemoveFrom( "networkstring", str )
    end
end

-- CSLuaFiles
function GetCSLuaFiles()
    return stringtable.GetStrings( "client_lua_files" )
end

function ClearSCLuaFiles()
    stringtable.Clear( "client_lua_files" )
end

function RemoveCSLuaFile( path )
    if isstring( path ) then
        stringtable.RemoveFrom( "client_lua_files", path )
    end
end

-- PrecacheModels
function util.GetPrecacheModels()
    return stringtable.GetStrings( "modelprecache" )
end

function util.ClearPrecacheModels()
    stringtable.Clear( "modelprecache" )
end

-- PrecacheSounds
function util.GetPrecacheSounds()
    return stringtable.GetStrings( "soundprecache" )
end

function util.ClearPrecacheSounds()
    stringtable.Clear( "soundprecache" )
end

-- PrecacheDecals
function util.GetPrecacheDecals()
    return stringtable.GetStrings( "decalprecache" )
end

function util.ClearPrecacheDecals()
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

-- GetCSLuaFiles() -- получить все файлы которые отправят клиенту ( моя функция )
-- RemoveCSLuaFile( path ) -- удалить файл из отправки клиенту ( моя функция )
-- AddCSLuaFile( path ) -- добавить файл для отправки клиенту ( гарис модь )
