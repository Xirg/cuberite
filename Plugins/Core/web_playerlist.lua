function HandleRequest_PlayerList( Request )
	local World = cRoot:Get():GetWorld()
	local Content = ""
	
	if( Request.Params["playerlist-kick"] ~= nil ) then
		local KickPlayerName = Request.Params["playerlist-kick"]
		local Player = World:GetPlayer( KickPlayerName )
		if( Player == nil ) then
			Content = Content .. "<p>Could not find player " .. KickPlayerName .. " !</p>"
		elseif( Player:GetName() == KickPlayerName ) then
			Player:GetClientHandle():Kick("You were kicked from the game!")
			Content = Content .. "<p>" .. KickPlayerName .. " has been kicked from the game!</p>"
		end
	end
	
	Content = Content .. "<p>Connected Players: <b>" .. World:GetNumPlayers() .. "</b></p>"
	Content = Content .. "<table>"
	
	local PlayerNum = 0
	local AddPlayerToTable = function( Player )
		PlayerNum = PlayerNum + 1
		Content = Content .. "<tr>"
		Content = Content .. "<td style='width: 10px;'>" .. PlayerNum .. ".</td>"
		Content = Content .. "<td>" .. Player:GetName() .. "</td>"
		Content = Content .. "<td><a href='?playerlist-kick=" .. Player:GetName() .. "'>Kick</a></td>"
		Content = Content .. "</tr>"
	end
	World:ForEachPlayer( AddPlayerToTable )

	if( PlayerNum == 0 ) then
		Content = Content .. "<tr><td>None</td></tr>"
	end
	Content = Content .. "</table>"
	Content = Content .. "<br>"
	return Content
end