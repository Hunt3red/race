--Pringus race script (probably more accurately a time trial script)
--todo: add laps, placements, spawn positions, time conversion, option to join

function LocalPed()
	return GetPlayerPed(-1)
end

local startPoint = {x = 2452.0422363281, y = 4584.0, z = 37.0}

--Edit the xyz coords of this blip to change the starting line for the race
local blips = {
    {title="Jagger", colour=5, id=315, x= startPoint.x, y= startPoint.y, z= startPoint.z}
}


local IsRacing = false 
local cP = 0
local cP2 = 0
local checkpoint
local blip
local startTime
local position = 1

racers = {}
for i = 1,32 do
    racers[i] = {plCP = 0, plID = 0}
end

racers2 = {}
for i = 1,32 do
    racers2[i] = {plCP = 0, plID = 0}
end



local CheckPoints = {}

CheckPoints[1] = {x = 2359.6828613281,y = 4681.8369140625,z = 38.294208526611, type = 5}
CheckPoints[2] = {x = 2024.4761962891,y = 4622.0478515625,z = 42.496269226074, type = 5}
CheckPoints[3] = {x = 1758.7360839844,y = 4575.2133789063,z = 37.806930541992, type = 5}
CheckPoints[4] = {x = 1695.5875244141,y = 4658.6010742188,z = 42.754390716553, type = 5}
CheckPoints[5] = {x = 1667.4906005859,y = 4932.4643554688,z = 41.370155334473, type = 5}
CheckPoints[6] = {x = 1822.0274658203,y = 5067.0131835938,z = 57.311798095703, type = 5}
CheckPoints[7] = {x = 1988.0649414063,y = 5151.0913085938,z = 44.161609649658, type = 9}
CheckPoints[8] = {x = 2133.287109375,y = 5225.6987304688,z = 57.853595733643, type = 5}
CheckPoints[9] = {x = 2299.6638183594,y = 5187.1000976563,z = 59.099498748779, type = 5}
CheckPoints[10] = {x = 2366.2592773438,y = 5225.7915039063,z = 57.961486816406, type = 5}
CheckPoints[11] = {x = 2392.0808105469,y = 5082.7690429688,z = 54.411712646484, type = 5}
CheckPoints[12] = {x = 2390.0864257813,y = 4925.6455078125,z = 56.390571594238, type = 5}
CheckPoints[13] = {x = 2256.7502441406,y = 4905.0639648438,z = 53.033596038818, type = 5}
CheckPoints[14] = {x = 2195.3146972656,y = 4743.328125,z = 40.151760101318, type = 5}
CheckPoints[15] = {x = 2316.7524414063,y = 4744.4067382813,z = 49.53540802002, type = 5}
CheckPoints[16] = {x = 2206.08984375,y = 4825.6743164063,z = 39.431991577148, type = 5}
CheckPoints[17] = {x = 2214.5959472656,y = 4954.9482421875,z = 40.628261566162, type = 5}
CheckPoints[18] = {x = 2394.3962402344,y = 5140.9794921875,z = 46.695999145508, type = 5}
CheckPoints[19] = {x = 2526.111328125,y = 5088.208984375,z = 43.294586181641, type = 5}
CheckPoints[20] = {x = 2641.6149902344,y = 5128.908203125,z = 45.553276062012, type = 5}
CheckPoints[21] = {x = 2723.5100097656,y = 5114.140625,z = 43.336578369141, type = 5}
CheckPoints[22] = {x = 2770.0187988281,y = 4976.7670898438,z = 32.976810455322, type = 5}
CheckPoints[23] = {x = 2843.1066894531,y = 4814.6484375,z = 47.802055358887, type = 5}
CheckPoints[24] = {x = 2883.1142578125,y = 4745.1733398438,z = 47.964672088623, type = 5}
CheckPoints[25] = {x = 2969.4130859375,y = 4672.650390625,z = 51.371353149414, type = 5}
CheckPoints[26] = {x = 2970.2509765625,y = 4486.1220703125,z = 45.883026123047, type = 5}
CheckPoints[27] = {x = 2798.4643554688,y = 4410.2724609375,z = 48.173229217529, type = 5}
CheckPoints[28] = {x = 2730.2138671875,y = 4594.5346679688,z = 44.446239471436, type = 5}
CheckPoints[29] = {x = 2709.1586914063,y = 4754.482421875,z = 43.631923675537, type = 5}
CheckPoints[30] = {x = 2674.3056640625,y = 4967.4633789063,z = 44.019496917725, type = 5}
CheckPoints[31] = {x = 2624.7541503906,y = 5109.1694335938,z = 44.095062255859, type = 5}
CheckPoints[32] = {x = 2660.9526367188,y = 4910.744140625,z = 43.981155395508, type = 5}
CheckPoints[33] = {x = 2748.9262695313,y = 4769.2407226563,z = 51.226440429688, type = 5}
CheckPoints[34] = {x = 2688.7775878906,y = 4844.0454101563,z = 32.93334197998, type = 5}
CheckPoints[35] = {x = 2457.6501464844,y = 4613.25,z = 36.130588531494, type = 5}
CheckPoints[36] = {x = 2445.5249023438, y = 4601.2626953125, z = 36.481945037842, type = 9}


Citizen.CreateThread(function()
    raceInit()
end)

function raceInit()
    while not IsRacing do
        Citizen.Wait(0)
            DrawMarker(1, startPoint.x, startPoint.y, startPoint.z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0) 
        if GetDistanceBetweenCoords( startPoint.x, startPoint.y, startPoint.z, GetEntityCoords(LocalPed())) < 50.0 then
            	Draw3DText( startPoint.x, startPoint.y, startPoint.z  +.500, "Jagger",7,0.3,0.2)
            	Draw3DText( startPoint.x, startPoint.y, startPoint.z  +.100, "Race",7,0.3,0.2)
        end
        if GetDistanceBetweenCoords( startPoint.x, startPoint.y, startPoint.z, GetEntityCoords(LocalPed())) < 2.0 then
            TriggerEvent("fs_freemode:displayHelp", "Press ~INPUT_CONTEXT~ to Race!")
            if (IsControlJustReleased(1, 38)) then
                if IsRacing == false then
                    IsRacing = true
                    TriggerServerEvent("cRaceS:RequestRace")
                    TriggerEvent("cRace:PreRace")
                else
                    return
                end
            end
        end
    end
end

RegisterNetEvent("cRace:JoinRace") --Triggered for all players
AddEventHandler("cRace:JoinRace", function(host)
    Citizen.CreateThread(function()
        local time = 0
        function setcountdown(x)
          time = GetGameTimer() + x*1000
        end
        function getcountdown()
          return math.floor((time-GetGameTimer())/1000)
        end
        setcountdown(11)
        
        while getcountdown() > 0 do
            Citizen.Wait(1)
            TriggerEvent("fs_freemode:displayHelp", "Press ~INPUT_CONTEXT~ to join " .. host .. "'s race! " .. getcountdown())
                if (IsControlJustReleased(1, 38)) then
                    if IsRacing == false then
                        IsRacing = true
                        TriggerEvent("cRace:PreRace")
                    else
                        return
                    end
                end
        end
        if IsRacing == true then
            TriggerEvent("cRace:TPAll")
        end
    end)
end)

RegisterNetEvent ("cRace:PreRace")
AddEventHandler("cRace:PreRace", function()
    
    SetEntityHeading(PlayerPedId(), 21.0)

    local startCoords = {}
    startCoords[0] = {x=2449.40,y=4578.88,z=36.61}
    startCoords[1] = {x=2453.66,y=4567.82,z=36.61}
    startCoords[2] = {x=2457.85,y=4556.90,z=36.61}
    startCoords[3] = {x=2461.97,y=4546.17,z=36.62}
    startCoords[4] = {x=2466.04,y=4535.57,z=36.62}
    startCoords[5] = {x=2470.34,y=4524.36,z=36.62}
    startCoords[6] = {x=2474.51,y=4513.48,z=36.62}
    startCoords[7] = {x=2478.76,y=4502.34,z=36.61}
    startCoords[8] = {x=2457.64,y=4576.05,z=36.62}
    startCoords[9] = {x=2466.24,y=4553.79,z=36.62}
    startCoords[10] = {x=2470.14,y=4542.86,z=36.62}
    startCoords[11] = {x=2474.02,y=4532.41,z=36.62}
    startCoords[12] = {x=2478.18,y=4521.17,z=36.62}


    SetPedCoordsKeepVehicle(PlayerPedId(), startCoords[PlayerId()].x, startCoords[PlayerId()].y, startPoint.z, true)

end)

RegisterNetEvent("cRace:TPAll")
AddEventHandler("cRace:TPAll", function()
Citizen.CreateThread(function()
        local time = 0
        function setcountdown(x)
          time = GetGameTimer() + x*1000
        end
        function getcountdown()
          return math.floor((time-GetGameTimer())/1000)
        end
        setcountdown(6)
        while getcountdown() > 0 do
            Citizen.Wait(1)
            DrawHudText(getcountdown(), {255,191,0,255},0.5,0.4,4.0,4.0)
        end
            TriggerEvent("cRace:BeginRace", 1, 2)
    end)
end)

RegisterNetEvent("cRace:BeginRace") --main loop
AddEventHandler("cRace:BeginRace", function(cP, cP2)
    startTime = GetGameTimer()
    Citizen.CreateThread(function()
        checkpoint = CreateCheckpoint(CheckPoints[cP].type, CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z + 2, CheckPoints[cP2].x, CheckPoints[cP2].y, CheckPoints[cP2].z, 8.0, 204, 204, 1, 100, 0)
        blip = AddBlipForCoord(CheckPoints[cP].x, CheckPoints[cP].y, CheckPoints[cP].z)          
        while IsRacing do
            Citizen.Wait(5)
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetPedDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)


            DrawHudText("Position: " .. position .. " place", {249, 249, 249,255},0.0,0.5,1.0,1.0)
            DrawHudText(math.floor(GetDistanceBetweenCoords(CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z, GetEntityCoords(GetPlayerPed(-1)))) .. " meters", {249, 249, 249,255},0.0,0.75,1.0,1.0)
            DrawHudText(string.format("%i / %i", cP, tablelength(CheckPoints)), {249, 249, 249, 255},0.7,0.0,1.5,1.5)
            DrawHudText(formatTimer(startTime, GetGameTimer()), {249, 249, 249,255},0.0,0.0,1.5,1.5)
                if GetDistanceBetweenCoords(CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
                    if CheckPoints[cP].type == 5 then
                        TriggerServerEvent("cRaceS:recieveCP", cP)
                        DeleteCheckpoint(checkpoint)
                        RemoveBlip(blip)
                        PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
                        cP = math.ceil(cP+1)
                        cP2 = math.ceil(cP2+1)
                        checkpoint = CreateCheckpoint(CheckPoints[cP].type, CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z + 2, CheckPoints[cP2].x, CheckPoints[cP2].y, CheckPoints[cP2].z, 8.0, 204, 204, 1, 100, 0)
                        blip = AddBlipForCoord(CheckPoints[cP].x, CheckPoints[cP].y, CheckPoints[cP].z)
                    else
                        TriggerServerEvent("cRaceS:recieveCP", cP)
                        PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
                        DeleteCheckpoint(checkpoint)
                        RemoveBlip(blip)
                        IsRacing = false
                        cP = 0
                        cP2 = 0
                        TriggerServerEvent("recieveTime", formatTimer(startTime, GetGameTimer()))
                        --TriggerEvent("chatMessage", "Server", {0,0,0}, string.format("Finished with a time of " .. formatTimer(startTime, GetGameTimer())))
                        raceInit()
                    end
                end
        end
    end)
end)

RegisterNetEvent("cRace:sendCP")
AddEventHandler("cRace:sendCP", function(acP, source)
    racers[source] = {plCP = acP, plID = source} --control table, indexes are player ID's
    racers2 = shallowcopy(racers) -- copied table, indexes are race positions
    table.sort(racers2, function(a,b)
        return a.plCP > b.plCP
    end)
        local index={} --reverse index table to find index of racers2
        for i,d in pairs(racers2) do
            for k,v in pairs(racers2[i]) do
                if k == "plID" then
                index[v]=i
                end
            end
        end
        position = index[source]
end)

function calculateDistance()
    local raceDist
    
end

RegisterNetEvent("stopRace")
AddEventHandler("stopRace", function()
    PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
    DeleteCheckpoint(checkpoint)
    RemoveBlip(blip)
    IsRacing = false
    cP = 0
    cP2 = 0
    raceInit()
end)

--utility funcs
function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function sendCP(acP)
    TriggerServerEvent("cRaceS:recieveCP", acP)
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do 
    count = count + 1 end
    return count
end

function formatTimer(startTime, currTime)
    local newString = currTime - startTime
        local ms = string.sub(newString, -3, -2)
        local sec = string.sub(newString, -5, -4)
        local min = string.sub(newString, -7, -6)
        --newString = string.sub(newString, -1)
        newString = string.format("%s%s.%s", min, sec, ms)
    return newString
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
         local px,py,pz=table.unpack(GetGameplayCamCoords())
         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    
         local scale = (1/dist)*20
         local fov = (1/GetGameplayCamFov())*100
         local scale = scale*fov
    
         SetTextScale(scaleX*scale, scaleY*scale)
         SetTextFont(fontId)
         SetTextProportional(1)
         SetTextColour(255, 255, 255, 250)
         SetTextDropshadow(1, 1, 1, 1, 255)
         SetTextEdge(2, 0, 0, 0, 150)
         SetTextDropShadow()
         SetTextOutline()
         SetTextEntry("STRING")
         SetTextCentre(1)
         AddTextComponentString(textInput)
         SetDrawOrigin(x,y,z+2, 0)
         DrawText(0.0, 0.0)
         ClearDrawOrigin()
        end

function DrawHudText(text,colour,coordsx,coordsy,scalex,scaley) --courtesy of driftcounter
    SetTextFont(7)
    SetTextProportional(7)
    SetTextScale(scalex, scaley)
    local colourr,colourg,colourb,coloura = table.unpack(colour)
    SetTextColour(colourr,colourg,colourb, coloura)
    SetTextDropshadow(0, 0, 0, 0, coloura)
    SetTextEdge(1, 0, 0, 0, coloura)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(coordsx,coordsy)
end

--create blip
Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 1.0)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)
