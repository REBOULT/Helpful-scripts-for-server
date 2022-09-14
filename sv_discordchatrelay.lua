require("chttp")
local Config = {
	Webhook = "https://discord.com/api/webhooks/1010961606827585587/RNbFh_aJ7ov-GMbHDwYljuz0bCKFSA9mx_y_z-XAKcvuhtFfZf3JHb3K09umOXOh5cGv", -- https://pastebin.com/Bdh5EgmM
	SteamApiKey = "AE120F9D400B4C50361C8CDF518701B2" -- https://steamcommunity.com/dev/apikey
}

if pcall(require, "chttp") and CHTTP ~= nil then
	HTTP = CHTTP
else
	return MsgC(Color(255, 0, 0), "Discord Chat Relay ERROR!", Color(255, 255, 255), "Please install https://github.com/timschumi/gmod-chttp!")
end

local Avatars = {}
local AvatarsApi = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/"

local Red, White = Color(255, 0, 0), Color(255, 255, 255)

local function ParseJson(json, ...)
    local tbl = util.JSONToTable(json)
    if tbl == nil then return end

    local args = {...}

    for _, key in pairs(args) do
        if tbl[key] then
            tbl = tbl[key]
        end
    end

    return tbl
end


local function GetAvatar(ply, callback, attempts)
	attempts = attempts or 3
	local sid = ply:SteamID64()

	if Avatars[sid] then
		return callback(Avatars[sid])
	end

	HTTP({
		method = "get",
		url = AvatarsApi,
		parameters = {
			key = Config.SteamApiKey,
			steamids = sid
		},
		failed = function(error)
			MsgC(Red, "Steam Avatar API HTTP Error:", White, error, "\n")
			attempts = attempts - 1
			if attempts > 0 then
				GetAvatar(ply, callback, attempts)
			else
				Avatars[sid] = "https://i.imgur.com/up9fyXY.png"
				callback(Avatars[sid])
			end
		end,
		success = function(code, response)
			local avatar = ParseJson(response, "response", "players", 1, "avatarfull")
			if avatar then
				Avatars[sid] = avatar
				callback(avatar)
			else
				return MsgC(Red, "Steam Avatar API Error:", White, "Cant parse avatar\n")
			end
		end
	})
end

if pcall(require, "chttp") and CHTTP ~= nil then
	my_http = CHTTP
else
	my_http = HTTP
end

hook.Add("PlayerAuthed", "DiscordChatRelay", function(ply)
	GetAvatar(ply, function() end) -- pre-cache
end)

hook.Add("PlayerSay", "DiscordChatRelay", function(ply, text, isteam)
	GetAvatar(ply, function(avatar)
		HTTP({
			method = "post",
			type = "application/json; charset=utf-8",
			headers = {
				["User-Agent"] = "Discord Chat Relay",
			},
			url = Config.Webhook,
			body  = util.TableToJSON({
				content = text,
				username = ply:Nick(),
				avatar_url = avatar
			}),
			failed = function(error)
				MsgC(Red, "Discord API HTTP Error:", White, error, "\n")
			end,
			success = function(code, response)
				if code ~= 204 then
					MsgC(Red, "Discord API HTTP Error:", White, code, response, "\n")
				end
			end
		})
	end)
end)
return CHTTP()