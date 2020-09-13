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
    local memberid = message.member.id
    


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
        local memberID = message.author.id
        message:reply('Your ID is \"'..memberID..'\"')
    end


    if message then
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

    if message.content == prefix..'messages' then
        local open = io.open("data.json", "r")
        local parse = json.parse(open:read())
        open:close()
        message:reply('You have sent '..parse[message.member.id].." messages in the server!")
    end

    
end)

client:run('Bot NzQ5ODAwOTM2MDU4MjU3NTYz.X0xQiQ.SYSTPTDrlRiXf99RZ49k-maj6rA')