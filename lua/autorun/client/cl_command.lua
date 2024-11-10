local isAllowedFreeze = false -- Включено или выключено автофриз пропов при отпускании физгана
local command = "!autofreezeprops"
local whoCanUsingCommand = {
	"STEAM_0:0:847625196"
}

net.Receive('afprops_SendToChat', function()
	local text = net.ReadString()
	chat.AddText(text)
end)

hook.Add('OnPlayerChat', 'autoFreezePropEnableDisableCommand', function(ply, strText, bTeam, bDead) 
	if strText == command then
		for _, steamID in pairs(whoCanUsingCommand) do
			if tostring(ply:SteamID()) == tostring(steamID) then
				local newStatus = !isAllowedFreeze
				isAllowedFreeze = newStatus

				net.Start('EnableDisableAutoFreezeProps')
				net.WriteEntity(ply)
				net.WriteBool(newStatus)
				net.SendToServer()
			end
		end
	end
end)