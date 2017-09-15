function LocalPed()
	return GetPlayerPed(-1)
end
 
local IsRacing = false 

local CheckPoints = {
    { x = -721.81, y = 1011.66, z = 240.07, destx= -703.81, desty= 1110.66, destz=  258.07},
    { x = -703.81, y = 1110.66, z = 258.07, destx= -730.58, desty= 1156.81, destz= 263.38},
    { x = -730.58, y = 1156.81, z = 263.38, destx= -641.09, desty= 1352.34, destz= 292.32},
    { x = -641.09, y = 1352.34, z = 292.32, destx= -486.13, desty= 1341.10, destz= 304.63},
    { x = -486.13, y = 1341.10, z = 304.63, destx= -449.22, desty= 1382.59, destz= 298.28},
    { x = -449.22, y = 1382.59, z = 298.28, destx= -202.89, desty= 1491.26, destz= 289.27},
    { x = -202.89, y = 1491.26, z = 289.27, destx= -101.97, desty= 1510.28, destz= 285.29},
    { x = -101.97, y = 1510.28, z = 285.29, destx= -3.79,   desty= 1436.16, destz= 275.49},
    { x = -3.79,   y = 1436.16, z = 275.49, destx= 60.77,   desty= 1422.15, destz= 265.22},
    { x = 60.77,   y = 1422.15, z = 265.22, destx= 134.47,  desty= 1392.49, destz= 255.22},
    { x = 134.47,  y = 1392.49, z = 255.22, destx= 238.25,  desty= 1340.14, destz= 238.71},
    { x = 238.25,  y = 1340.14, z = 238.71, destx= 248.31,  desty= 1248.25, destz= 232.41},
    { x = 248.31,  y = 1248.25, z = 232.41, destx= 280.26,  desty= 1114.33, destz= 219.29},
    { x = 280.26,  y = 1114.33, z = 219.29, destx= 309.46,  desty= 1002.59, destz= 210.91},
    { x = 309.46,  y = 1002.59, z = 210.91, destx= 258.94,  desty= 977.41,  destz= 210.93},
    { x = 258.94,  y = 977.41,  z = 210.93, destx= 220.16,  desty= 920.30,  destz= 209.21},
    { x = 220.16,  y = 920.30,  z = 209.21, destx= 146.43,  desty= 934.52,  destz= 210.29},
    { x = 146.43,  y = 934.52,  z = 210.29, destx= 63.47,  desty= 1027.34,  destz= 217.69},
    { x = 63.47,   y = 1027.34, z = 217.69, destx= -65.24,  desty= 1054.43, destz= 223.48},
    { x = -65.24,  y = 1054.43, z = 223.48, destx= -197.05, desty= 1046.27, destz= 233.94},
    { x = -197.05, y = 1046.27, z = 232.94, destx= -331.87, desty= 969.99,  destz= 233.69},
    { x = -331.87, y = 969.99,  z = 233.69, destx= -412.52, desty= 908.84,  destz= 236.84},
    { x = -412.52, y = 908.84,  z = 236.84, destx= -525.33, desty= 915.24,  destz= 243.37},
    { x = -525.33, y = 915.24,  z = 243.37, destx= -627.54, desty= 995.15,  destz= 240.38},
    { x = -627.54, y = 995.15,  z = 240.38, destx= -743.62, desty= 979.70,  destz= 238.24},  -- Dest coords are for finish @ line 75.
}   

--Arrows to low to the ground? Add 1.0 or 2.0 to Z. 

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
    DrawMarker(1, -711.61, 1000.70, 237.07 - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0) 
	if GetDistanceBetweenCoords( -711.61, 1000.70, 237.07, GetEntityCoords(LocalPed())) < 50.0 then
        Draw3DText( -711.61, 1000.70, 237.07  +.500, "Street",7,0.3,0.2)
        Draw3DText( -711.61, 1000.70, 237.07  +.100, "Race ",7,0.3,0.2)
		end
		if GetDistanceBetweenCoords( -711.61, 1000.70, 237.07, GetEntityCoords(LocalPed())) < 2.0 then
		race()
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
end
end
end 


RegisterNetEvent("fs_race")
AddEventHandler("fs_race", function(IsRacing)
 Citizen.CreateThread(function()
 Citizen.Wait(0)
 if IsRacing then 
	Citizen.Trace("yes") 
			for k,v in ipairs(CheckPoints) do
			CreateCheckpoint(5, v.x, v .y, v .z, v.destx, v.desty, v.destz, 8.0, 204, 204, 1, 100, 0)
		end
	
	--Finish line
	CreateCheckpoint(9, -743.62, 979.70, 238.24, 0, 0, 0, 10.0, 0, 0, 200, 100, 0)			
        
		else
            Citizen.Trace("no")
				end 	 
		 
    end)
end)

--- Disabling traffic for clients in race. 
Citizen.CreateThread(function(IsRacing)
   while IsRacing do
        Citizen.Wait(0)

		SetVehicleDensityMultiplierThisFrame(0.0)
        SetRandomVehicleDensityMultiplierThisFrame(0.0)
        SetParkedVehicleDensityMultiplierThisFrame(0.0)
    end
end)




 function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY) -- A function tells what to do 
         -- RequestStreamedTextureDict( "mpmissmarkers128" )
         -- RequestStreamedTextureDict( "mpleaderboard" )
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
         -- DrawSprite( "mpmissmarkers256", "golf_icon", 0, 0, 0, 0, 0, 255, 255, 255, 255 )
         ClearDrawOrigin()
        end
		
--Blips (Needs replacement(?)) 
		
		local blips = {
		{title="Race", colour=5, id=315, x= -711.61, y= 1000.70, z= 237.07}
  }

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