-- Dont see this else u gay?
-- made by ALONE-OP#0001

local a={
    [1]={enter=vector3(-1497.312,829.493,181.613),mat=vector4(-1496.948,828.353,181.624,183.451)},
    [2]={enter=vector3(-1495.748,829.987,181.611),mat=vector4(-1495.347,829.098,181.623,206.668)},
    [3]={enter=vector3(-1493.391,830.833,181.61),mat=vector4(-1493.182,829.801,181.623,191.704)},
    [4]={enter=vector3(-1491.835,831.305,181.61),mat=vector4(-1491.527,830.35,181.624,202.751)}
}

local function b()
    local c=GetEntityCoords(PlayerPedId())
    local d=1000
    local e
    for f=1,#a do
        local g=#(c-a[f].enter)
        if g<d then
            d=g
            e=f
        end
    end
    return d,e
end

local h=false
local c=false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local i,j=b()
        if h then
            if i>5 then
                TriggerServerEvent('op-yoga:fuckYoga')
            end
        else
            if not IsPedInAnyVehicle(PlayerPedId()) then
                if i<1.5 then
                      DrawText3D(a[j].enter.x,a[j].enter.y,a[j].enter.z, "[E] to do Yoga")
                    if IsControlJustReleased(0,38)then
                        c=true
                        Citizen.Wait(10)
                        TriggerEvent('op-yoga:doYoga',j)
                    end
                elseif i<2.5 then
                    DrawText3D(a[j].enter.x,a[j].enter.y,a[j].enter.z, "Do Yoga")else
                    Citizen.Wait(math.ceil(i*20))
                end
            else
                Citizen.Wait(500)
            end
        end
    end
end)
        

local k=false

AddEventHandler('op-yoga:removeStress',function()
    if k then
        return
    end
    k=true
    while h do
        Citizen.Wait(10000)
    if h then
        TriggerServerEvent('op-hud:Server:RelieveStress', math.random(1,13))
    end
end
k=false
end)

RegisterNetEvent('op-yoga:doYoga')
AddEventHandler('op-yoga:doYoga',function(cords)
    if c then
        print(cords)
        local m=PlayerPedId()
        SetEntityCoords(m,a[cords].mat.x,a[cords].mat.y,a[cords].mat.z-1.0)
        SetEntityHeading(m,a[cords].mat.w)
        loadanim("amb@world_human_yoga@male@base")
        TaskPlayAnim(m,"amb@world_human_yoga@male@base","base_a",1.0,1.0,-1,8,0,0,0,0)
        RemoveAnimDict("amb@world_human_yoga@male@base")
        h=true
        TriggerEvent('op-yoga:removeStress')
     while h do
        helpText('Press ~INPUT_CONTEXT~ to stop doing Yoga')
        if IsControlJustReleased(0,38)then
            Citizen.Wait(0)
            h=false
            TriggerServerEvent('op-yoga:fuckYoga')
        end
        if not IsEntityPlayingAnim(m,'amb@world_human_yoga@male@base','base_a',3)then
            TaskPlayAnim(m,'amb@world_human_yoga@male@base','base_a',1.0,1.0,-1,8,-1,0,0,0)
        end
        Citizen.Wait(0)
    end
    ClearPedTasks(m)
else
    helpText('This Mat is occupied')
end
h=false
end)

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function loadanim(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

Citizen.CreateThread(function()
    local n=AddBlipForCoord(-1494.097,829.044,181.604)
    SetBlipSprite(n,197)
    SetBlipScale(n,0.9)
    SetBlipColour(n,4)
    SetBlipDisplay(n,4)
    SetBlipAsShortRange(n,true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("yoga")
    EndTextCommandSetBlipName(n)
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255,255,255,215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor=string.len(text)/370
    DrawRect(0.0,0.0+0.0125,0.015+factor,0.03,41,11,41,68)
    ClearDrawOrigin()
end
