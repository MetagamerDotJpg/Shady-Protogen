local discordia = require('discordia')
local client = discordia.Client()
local timer = require('timer')
local json = require('json')
local prefix = '^'

client:on('ready', function()
	-- client.user is the path for your bot
	print('Logged in as \''.. client.user.username..'\'')
end)


client:on('messageCreate', function(message)

    local content = message.content


    if message.content == prefix.. 'help' then
        message:reply('<@!'..message.member.id..'>, I\'ve sent you a list of commands in DMs. If you did not get a DM, check your privacy settings.')
        message.author:send {
            embed = {
                title = 'Help',
                desription = 'Below are all the commands/features this bot has. Prefix is \'^\'',
                auther = {
                    name = message.author.username,
                    icon_url = message.author.avatarURL,
                },
                fields = {
                    {
                        name = 'Help',
                        value = 'This command!',
                        inline = false
                    },
                    {
                        name = 'Messages',
                        value = 'Tells you how many messages you have sent in the server. This number goes up every message you send **when the bot is online!**',
                        inline = false
                    },
                },
                footer = {
                    test = 'Bot is still in development, expect bugs!'
                },
                color = 0x000000
            }
        }
    end


    if message.content == '!ping' then
        timer.sleep(1000)
        message:reply('Pong!')
    end

    if message.content == prefix..'gay' then
        local gaypercent = math.random(1,100)
        message:reply('You are '..gaypercent..'% gay.')
    end

    if message.content == prefix..'rgb.random' then
        local colours = {"red", "blue", "green"}
        message:reply( colours[ math.random( #colours ) ] )
    end

    if message.content == prefix..'id' then
        message:reply('Your ID is \"'..message.member.id'\"')
    end


    if message then
        if message.member then -- Ensures that the member object/id is found, prevents errors in DMs.
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

    if message.content == prefix..'messages' then
        local open = io.open("data.json", "r")
        local parse = json.parse(open:read())
        open:close()
        message:reply('You have sent '..parse[message.member.id].." messages in the server!")
    end

    if message.content == prefix..'count' then
        local list = {'A', 'B', 'C'}
        for key, v in pairs(list) do
            message:reply(v)
        end
    end


    
end)

client:run('Bot NzQ5ODAwOTM2MDU4MjU3NTYz.X0xQiQ.SYSTPTDrlRiXf99RZ49k-maj6rA')