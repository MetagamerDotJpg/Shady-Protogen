local prefix = "^"

local cmds = {}


    function cmds.help(args, message, timer, client)
        if args[1] == prefix.. 'help' then
            if message.member then
                message:reply('<@!'..message.member.id..'>, I\'ve sent you a list of commands in DMs. If you did not get a DM, check your privacy settings.')
                timer.sleep(1000)
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
                                value = 'Usage: \"^messages [optional mention]\" ',
                                inline = false
                            },
                            {
                                name = 'Fun Stuff',
                                value = 'Hug [optional mention]\nBoop [optional mention]\nKiss [optional mention]',
                                inline = false
                            },
                            {
                                name = 'Gauges/Meters [optional mention]',
                                value = 'Gay [optional mention]',
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
        end
    end
    
    function cmds.fun(message, args, mentioned)
        if message.member then
            local memberid = message.member.id
            if #mentioned == 1 and mentioned[1][1] ~= memberid then
                local cmdsMention = {
                    hug = '<@!'..message.member.id..'> jumps up and gives <@!'..mentioned[1][1]..'> a big hug!',
                    boop = '<@!'..message.member.id..'> boops <@!'..mentioned[1][1]..'> right on the nose!',
                    kiss = '<@!'..message.member.id..'> gives <@!'..mentioned[1][1]..'> a big smooch!'
                }
                for i,v in pairs(cmdsMention) do
                    if args[1] == prefix..i then
                        message:reply(v)
                    end
                end
            elseif #mentioned == 0 or mentioned[1][1] == memberid then
                local cmdsNoMention = {
                    hug = '<@!'..message.member.id..'> is lonely, can someone give them a hug?... please?',
                    boop = '<@!'..message.member.id..'> just booped themself on the nose, you okay?',
                    kiss = '<@!'..message.member.id..'>... wh... how?'
                }
                for i,v in pairs(cmdsNoMention) do
                    if args[1] == prefix..i then
                        message:reply(v)
                    end
                end
            end
        end
    end


    function cmds.Timer(args, message, timer)
        if args[1] == prefix..'timer' then
            if message.member then
                local error = '<@!'..message.member.id..'>, invalid arguments, that is not a number value! usage: `^timer` `time/minutes`'
                if args[2] == nil then
                    message:reply(error)
                elseif args[2] then
                    local timertime = tonumber(args[2])
                    if timertime then
                        message:reply('<@!'..message.member.id..'>, I have set a timer for '..args[2]..' minutes')
                        local minutes = args[2] * 60000
                        timer.sleep(minutes)
                        message:reply('<@!'..message.member.id..'>, your timer for '..args[2]..' minutes has expired!')
                    else
                        message:reply(error)
                    end
                end
            end
        end
    end

    function cmds.roll(args, message)
        if args[1] == prefix..'roll' then
            if message.member then
                if not args[2] or string.match(args[2], "%a") then 
                    message:reply('<@!'..message.member.id..'>, that is not a valid number! Usage: `^roll` `dice ammount (max 10)`')
                elseif args[2] >= '11' then
                    message:reply('<@!'..message.member.id..'>, that number is too big, max is 10!')
                elseif args[2] then
                    local dicecount = args[2] * 6
                    local diceroll = math.random(args[2], dicecount)
                    message:reply('<@!'..message.member.id..'> rolls '..args[2]..' dice, they roll a '..diceroll..'!')
                end
            end
        end
    end


    -- fun/random stuff

    function cmds.gay(args, mentioned, message)
        if message.member then
            if args[1] == prefix..'gay' then
                local gaypercent = math.random(1,100)
                if #mentioned == 1 then
                    message:reply('<@!'..mentioned[1][1]..'> is '..gaypercent..'% gay')
                elseif #mentioned == 0 then
                    message:reply('<@!'..message.member.id..'> is '..gaypercent..'% gay')
                end
            end
        end
    end

    --[[function cmds.hug(args, message, mentioned, client)
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
                                value = '<@!'..message.member.id..'> jumps up and gives <@!'..mentioned[1][1]..'> a big hug!',
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
    
            elseif #mentioned == 0 or mentioned == message.member.id then
                message:reply{
                    embed = {
                        title = 'hug',
                        author = {
                            name = message.author.username,
                            icon_url = message.author.avatarURL
                        },
                        fields = {
                            {   name = '‏‏‎ ‎',
                                value = '<@!'..message.member.id..'> is lonely, can someone give them a hug?',
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
    end
--]]


    

return cmds