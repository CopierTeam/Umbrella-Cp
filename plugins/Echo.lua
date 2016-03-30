local function tagall(cb_extra, success, result)
    local receiver = cb_extra.receiver
    local chat_id = "chat#id"..result.id
    local text = ''
    for k,v in pairs(result.members) do
        if v.username then
			text = text.."@"..v.username.."\n"
		end
    end
	text = text.."\n"..cb_extra.msg_text
	send_large_msg(receiver, text)
end
local function run(msg, matches)
local receiver = get_receiver(msg)
	if matches [1] == 'echo' and matches[2] == 'tag' then 
	  if not is_momod(msg) then
		return "فقط برای مدیران!"
	end
		chat_info(receiver, tagall, {receiver = receiver,msg_text = matches[1]})
	end
	return
end
if matches[1] == 'echo>' then
  local text = matches[2]
  local b = 1

  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local file = io.open("./data/echo"..msg.from.id..matches[3], "w")
  file:write(text)
  file:flush()
  file:close()
  send_document("chat#id"..msg.to.id,"./data/echo"..msg.from.id..matches[3], ok_cb, false)
end
if matches[1] == 'echo' then
  local text = matches[2]
  local b = 1

  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  return text
end

return {
  description = "Simplest plugin ever!",
  usage = "!echo [whatever]: echoes the msg",
  patterns = {
    "^([Ee]cho>) +(.+) (.*)$",
    "^([Ee]cho) +(.+)$",
    "^([Ee]cho) (tag) +(.+)
    
  },
  run = run
}
