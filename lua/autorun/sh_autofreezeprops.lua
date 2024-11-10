print('sv autofreezeprops started!')

local isAllowedFreeze = false -- Включено или выключено по умолчанию автофриз объектов. 

function getEnabledAutoFreezeProps() 
    return isAllowedFreeze
end

net.Receive("EnableDisableAutoFreezeProps", function()
    local ply = net.ReadEntity()
    local status = net.ReadBool()

    isAllowedFreeze = status
    net.Start("afprops_SendToChat")
    net.WriteString(string.format("%s (%s) %s автозамораживание пропов!", ply:Nick(), ply:SteamID(), status == true and "включил" or "выключил"))
    net.Send(ply)
end)

hook.Add('PhysgunDrop', 'AutoFreezeProps', function(ply, ent) 

    if (ply:IsPlayer() and isAllowedFreeze) then
        ent:GetPhysicsObject():EnableMotion(false)
    end

end)