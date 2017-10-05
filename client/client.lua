function LocalPed()
	return GetPlayerPed(-1)
end
 

local blips = {
    {title="Race", colour=5, id=315, x= -711.61, y= 1000.70, z= 237.07}
}


local CP1check = false
local IsRacing = false 
local cP = 0
local cP2 = 0

local CheckPoints = {} 
CheckPoints[1] =  	{ x = -721.81, y = 1011.66, z = 240.07}
CheckPoints[2] =	{ x = -703.81, y = 1110.66, z = 258.07}
CheckPoints[3] =	{ x = -730.58, y = 1156.81, z = 263.38}
CheckPoints[4] =	{ x = -641.09, y = 1352.34, z = 292.32}
CheckPoints[5] =	{ x = -486.13, y = 1341.10, z = 304.63}
CheckPoints[6] =	{ x = -449.22, y = 1382.59, z = 298.28}
CheckPoints[7] =	{ x = -202.89, y = 1491.26, z = 289.27}
CheckPoints[8] =	{ x = -101.97, y = 1510.28, z = 285.29}
CheckPoints[9] =	{ x = -3.79,   y = 1436.16, z = 275.49}
CheckPoints[10] =	{ x = 60.77,   y = 1422.15, z = 265.22}
CheckPoints[11] =  	{ x = 134.47,  y = 1392.49, z = 255.22}
CheckPoints[12] =  	{ x = 238.25,  y = 1340.14, z = 238.71}
CheckPoints[13] =  	{ x = 248.31,  y = 1248.25, z = 232.41}
CheckPoints[14] =	{ x = 280.26,  y = 1114.33, z = 219.29}
CheckPoints[15] =  	{ x = 309.46,  y = 1002.59, z = 210.91}
CheckPoints[16] =  	{ x = 258.94,  y = 977.41,  z = 210.93}
CheckPoints[17] =  	{ x = 220.16,  y = 920.30,  z = 209.21}
CheckPoints[18] =  	{ x = 146.43,  y = 934.52,  z = 210.29}
CheckPoints[19] =  	{ x = 63.47,   y = 1027.34, z = 217.69}
CheckPoints[20] =  	{ x = -65.24,  y = 1054.43, z = 223.48}
CheckPoints[21] =  	{ x = -197.05, y = 1046.27, z = 232.94}
CheckPoints[22] =  	{ x = -331.87, y = 969.99,  z = 233.69}
CheckPoints[23] =  	{ x = -412.52, y = 908.84,  z = 236.84}
CheckPoints[24] =  	{ x = -525.33, y = 915.24,  z = 243.37}
CheckPoints[25] =  	{ x = -627.54, y = 995.15,  z = 240.38}
CheckPoints[26] =  	{ x = 0, y = 0,  z = 0}
CheckPoints[27] =  	{ x = 0, y = 0,  z = 0},


   


--Arrows to low to the ground? Add 1.0 or 2.0 to Z. 

Citizen.CreateThread(function()
	while not IsRacing do
        Citizen.Wait(0)
        DrawMarker(1, -711.61, 1000.70, 237.07 - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0) 
        if GetDistanceBetweenCoords( -711.61, 1000.70, 237.07, GetEntityCoords(LocalPed())) < 50.0 then
            Draw3DText( -711.61, 1000.70, 237.07  +.500, "Street",7,0.3,0.2)
            Draw3DText( -711.61, 1000.70, 237.07  +.100, "Race ",7,0.3,0.2)
        end

        if GetDistanceBetweenCoords( -711.61, 1000.70, 237.07, GetEntityCoords(LocalPed())) < 2.0 then
            race()
        end

        if GetDistanceBetweenCoords(-743.62, 979.70, 238.24, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
            TriggerEvent("fs_race", false)
        end
    end
end)


function race()
    TriggerEvent("fs_freemode:displayHelp", "Press ~INPUT_CONTEXT~ to Race!")
    if (IsControlJustReleased(1, 38)) then
        if IsRacing == false then 
            IsRacing = true 
            TriggerEvent("fs_race", true)
        else
            TriggerEvent("fs_race", false)
        end
    end
end

RegisterNetEvent("fs_race:RequestCP")
AddEventHandler("fs_race:RequestCP", function(cP, cP2)
	Citizen.CreateThread(function()
		Citizen.Wait(5) 
			if IsRacing then
				cP = 1
				cP2 = 2
				TriggerEvent("fs_race:CP", cP, cP2)  
			end 
	end) 
	
Citizen.CreateThread(function()
	while IsRacing do 
		Citizen.Wait(5) 
			if GetDistanceBetweenCoords(CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
				
				
				cP = math.ceil(cP+1)
				cP2 = math.ceil(cP2+1)
				
				
				TriggerEvent("fs_race:CP", cP, cP2)  
				else 
			end 
			
		end 
	end)
end) 




RegisterNetEvent("fs_race:CP")
AddEventHandler("fs_race:CP", function(cP, cP2)
	if IsRacing and cP2 == 27 then 
		 
		local finishLine = CreateCheckpoint(9, -743.62, 979.70, 238.24, 0, 0, 0, 10.0, 0, 0, 200, 100, 0)	
			
			Citizen.Trace("finish made!")
			
		else
		
		local checkpoint = CreateCheckpoint(5, CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z, CheckPoints[cP2].x, CheckPoints[cP2].y, CheckPoints[cP2].z, 8.0, 204, 204, 1, 100, 0)
		local blip = AddBlipForCoord(CheckPoints[cP].x, CheckPoints[cP].y, CheckPoints[cP].z) 
		




	
Citizen.CreateThread(function()
	while IsRacing do 
		Citizen.Wait(5) 
			if GetDistanceBetweenCoords(CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
				DeleteCheckpoint(checkpoint)
					RemoveBlip(blip)
				 
			
			end 
		end
	end)
end
end)






RegisterNetEvent("fs_race")
AddEventHandler("fs_race", function(IsRacing, CheckPoints, cP, cP2)
     if IsRacing then 
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(GetPlayerPed(-1))
            
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
		

			TriggerEvent("fs_race:RequestCP", 1, 2)
		  
            --Finish line
            local finishLine = CreateCheckpoint(9, -743.62, 979.70, 238.24, 0, 0, 0, 10.0, 0, 0, 200, 100, 0)				
        end
    end)
	


function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY) -- A function tells what to do 
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
