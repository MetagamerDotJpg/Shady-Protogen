local discordia = require('discordia')
local client = discordia.Client()
local timer = require('timer')
local json = require('json')
local prefix = '^'
local cmds = require("./cmds")

discordia.extensions()

client:on('ready', function()
	-- client.user is the path for your bot
    print('Logged in as \''.. client.user.username..'\'')
    client:setStatus('^help or ping me for help!')
end)

client:on('messageCreate', function(message)
    
    local mentioned = message.mentionedUsers
    local args = message.content:split(" ")
    local member = message.member

------------------- From Module -----------------------

    cmds.fun(message, args, mentioned)

    cmds.help(args, message, timer, client)
    cmds.Timer(args, message, timer)
    cmds.roll(args, message)
    cmds.gay(args, mentioned, message)
    
--------------------------------------------------------
    
    
    
    if message then
        if message.member then -- Ensures that the member object/id is found, prevents errors/crashes in DMs.
            if not message.member.bot then -- Checks if the member is a bot (Prevents bots from getting parsed)
                local open = io.open("data.json", "r")
                local parse = json.parse(open:read())
                open:close()
                if parse[message.member.id] then
                    parse[message.member.id] = parse[message.member.id] + 1
                else
                    parse[message.member.id] = 1
                end
                open = io.open("data.json", "w")
                open:write(json.stringify(parse))
                open:close()
            end
        end
    end

    if args[1] == prefix..'messages' then
        local open = io.open("data.json", "r")
        local parse = json.parse(open:read())
        open:close()
        if #mentioned == 1 then
            message:reply('<@!'..mentioned[1][1]..'> has sent '..parse[mentioned[1][1]]..' messages in the server!')
        elseif #mentioned == 0 then
            message:reply('You have sent '..parse[message.member.id]..' messages in the server!')
        end
    end
end)


client:run("Bot "..io.open("./token/token.txt"):read())