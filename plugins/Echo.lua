--Tag ppl with username and a msg after it
local function tagall(cb_extra, success, result)
    local receiver = cb_extra.receiver
    local chat_id = "chat#id"..result.id
    local text = ''
    for k,v in pairs(result.members) do
        if v.username then
			text = text..v.first_name.."- @"..v.username.." ["..v.id.."]\n"
		end
    end
	text = text.."\n"..cb_extra.msg_text
	send_large_msg(receiver, text)
end
local function run(msg, matches)
    local receiver = get_receiver(msg)
	if not is_momod(msg) then 
		return "For Moderator only !"
	end
	if matches[3] then
		chat_info(receiver, tagall, {receiver = receiver,msg_text = matches[3]})
	end
	return
end

local function run(msg, matches)
  if matches[1] == 'echo' and matches[2] == 'tag' and matches[3] then
    return chat_info(receiver, tagall, {receiver = receiver,msg_text = matches[3]})
    end
if matches[1] == 'echo>' then
  local text = matches[3]
  local b = 1

  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local file = io.open("./Umbrella-Cp/data/echo/["..msg.from.id.."]|"..matches[2], "w")
  file:write(text)
  file:flush()
  file:close()
  send_document("chat#id"..msg.to.id,"./umbrella/echo/["..msg.from.id.."]|"..matches[2], ok_cb, false)
end
if matches[1] == 'echo' then
  if matches [2] == 'tag' then
    return
  end
  local text = matches[2]
  local b = 1

  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  return text
end
end

return {
  description = "Simplest plugin ever!",
  usage = "!echo [whatever]: echoes the msg",
  patterns = {
    "^([Ee]cho>) +(.+) (.*)$",
    "^([Ee]cho) +(.+)$",
    "^([Ee]cho) (tag) +(.+)$",
    
  },
  run = run
}
