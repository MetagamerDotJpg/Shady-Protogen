local discordia = require('discordia')
local client = discordia.Client()
local timer = require('timer')
local json = require('json')
local prefix = '^'


discordia.extensions()

client:on('ready', function()
	-- client.user is the path for your bot
	print('Logged in as \''.. client.user.username..'\'')
end)


client:on('messageCreate', function(message)



    local memberid = message.member.id
    local mentioned = message.mentionedUsers
    local args = message.content:split(" ")

    
    if message.content == prefix.. 'help' then
        message:reply('<@!'..memberid..'>, I\'ve sent you a list of commands in DMs. If you did not get a DM, check your privacy settings.')
        message.author:send {
            embed = {
                title = 'Help',
                description = 'Below are all the commands/features this bot has. Prefix is **^**',
                author = {
                    name = client.user.username,
                    icon_url = client.user.avatarURL,
                },
                fields = {
                    {
                        name = 'Help',
                        value = 'This command!',
                        inline = false
                    },
                    {
                        name = 'Messages',
                        value = 'Usage: \"^messages [mention]\" mention is optional and will return your own message count if left blank.',
                        inline = false
                    },
                    {
                        name = 'Fun Stuff [mention]',
                        value = 'Gay\nHug [mention]',
                        inline = false
                    },
                    {
                        name = 'Utility',
                        value = 'Timer [time/minutes]',
                        inline = false
                    },
                },
                footer = {
                    text = 'Bot is still in development, expect bugs!'
                },
                color = 0xFF59F2
            }
        }
    end

    if args[1] == prefix..'gay' then
        local gaypercent = math.random(1,100)
        if #mentioned == 1 then
            message:reply('<@!'..mentioned[1][1]..'> is '..gaypercent..'% gay')
        elseif #mentioned == 0 then
            message:reply('<@!'..memberid..'> is '..gaypercent..'% gay')
        end
    end

    if args[1] == prefix..'hug' then
        if #mentioned == 1 then
            message:reply {
                embed = {
                    title = 'hug',
                    author = {
                        name = message.author.username,
                        icon_url = message.author.avatarURL
                    },
                    fields = {
                        {
                            name = '‏‏‎ ‎',
                            value = '<@!'..memberid..'> jumps up and gives <@!'..mentioned[1][1]..'> a big hug!',
                            inline = false
                        },
                    },
                    footer = {
                        icon_url = client.user.avatarURL,
                        text = 'Shady Protogen#6330'
                    },
                    color = 0x000000
                }
            }

        elseif #mentioned == 0 or mentioned == memberid then
            message:reply{
                embed = {
                    title = 'hug',
                    author = {
                        name = message.author.username,
                        icon_url = message.author.avatarURL
                    },
                    fields = {
                        {   name = '‏‏‎ ‎',
                            value = '<@!'..memberid..'> is lonely, can someone give them a hug?',
                            inline = false
                        },
                    },
                    footer = {
                        icon_url = client.user.avatarURL,
                        text = 'Shady Protogen#6330'
                    },
                    color = 0x000000
                }
            }
    
        end
    end

    


    if message then
        if message.member then -- Ensures that the member object/id is found, prevents errors/crashes in DMs.
            if not message.member.bot then -- Checks if the member is a bot (Prevents bots from getting parsed)
                local open = io.open("data.json", "r")
                local parse = json.parse(open:read())
                open:close()
                if parse[memberid] then
                    parse[memberid] = parse[memberid] + 1
                else
                    parse[memberid] = 1
                end
                open = io.open("data.json", "w")
                open:write(json.stringify(parse))
                open:close()
            end
        end
    end

    if message.content:lower():sub(1,#'^messages') == prefix..'messages' then
        local open = io.open("data.json", "r")
        local parse = json.parse(open:read())
        open:close()
        if #mentioned == 1 then
            message:reply('<@!'..mentioned[1][1]..'> has sent '..parse[mentioned[1][1]]..' messages in the server!')
        elseif #mentioned == 0 then
            message:reply('You have sent '..parse[memberid]..' messages in the server!')
        end
    end

    if message.content == prefix..'rgb.random' then
        local colours = {"red", "blue", "green"}
        message:reply( colours[ math.random( #colours ) ] )
    end

    if args[1] == prefix..'roll' then
        if not args[2] or string.match(args[2], "%a") then 
            message:reply('<@!'..memberid..'>, that is not a valid number! Usage: `^timer` `dice ammount (max 10)`')
        elseif args[2] >= '11' then
            message:reply('<@!'..memberid..'>, that number is too big, max is 10!')
        elseif args[2] then
            local dicecount = args[2] * 6
            local diceroll = math.random(args[2], dicecount)
            message:reply('<@!'..memberid..'> rolls '..args[2]..' dice, they roll a '..diceroll..'!')
        end
    end

    if args[1] == prefix..'timer' then
        local error = '<@!'..memberid..'>, invalid arguments, that is not a number value! usage: `^timer` `time/minutes`'
        if args[2] == nil then
            message:reply(error)
        elseif string.match(args[2], "%a") then
            message:reply(error)
        elseif args[2] then
            local timertime = string.match(args[2], "%d")
            if timertime then
                message:reply('<@!'..memberid..'>, I have set a timer for '..args[2]..' minutes')
                local minutes = args[2] * 60000
                timer.sleep(minutes)
                message:reply('<@!'..memberid..'>, your timer for '..args[2]..' minutes has expired!')
            else
                message:reply(error)
            end
        end
    end


end)







client:run('Bot NzQ5ODAwOTM2MDU4MjU3NTYz.X0xQiQ.wQbGQI6rx-vn3QhvBuYJDbQRuV4')