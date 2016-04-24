do

local function set_pass(msg, pass, id)
  local hash = nil
  if msg.to.type == "chat" then
    hash = 'setpass:'
  end
  local name = string.gsub(msg.to.print_name, '_', '')
  if hash then
    redis:hset(hash, pass, id)
      return send_large_msg("chat#id"..msg.to.id, "🔱 User of Group:\n["..name.."] has been set to:‌\n\n "..pass.."\n\nNow user can join in pm by\njoin "..pass.." ⚜", ok_cb, true)
  end
end

local function is_used(pass)
  local hash = 'setpass:'
  local used = redis:hget(hash, pass)
  return used or false
end
local function show_add(cb_extra, success, result)
  —vardump(result)
    local receiver = cb_extra.receiver
    local text = "I added you to👥 "..result.title.."(👤"..result.participants_count..")"
    send_large_msg(receiver, text)
end
local function added(msg, target)
  local receiver = get_receiver(msg)
  chat_info("chat#id"..target, show_add, {receiver=receiver})
end
local function run(msg, matches)
  if matches[1] == "/user" and msg.to.type == "chat" and matches[2] then
    local pass = matches[2]
    local id = msg.to.id
    if is_used(pass) then
      return "این یوزر نیم قابل استفاده نیست"
    end
    redis:del("setpass:", id)
    return set_pass(msg, pass, id)
  end
  if matches[1] == "join" and matches[2] then
    local hash = 'setpass:'
    local pass = matches[2]
    local id = redis:hget(hash, pass)
    local receiver = get_receiver(msg)
    if not id then
      return "گروهی با این یوزر نیم وجود ندارد"
    end
    chat_add_user("chat#id"..id, "user#id"..msg.from.id, ok_cb, false) 
  return added(msg, id)
  else
  return " من نمیتوانم شما را به"..string.gsub(msg.to.id.print_name, '_', ' ').."اضافه کنم"
  end
  if matches[1] == "/user" then
   local hash = 'setpass:'
   local chat_id = msg.to.id
   local pass = redis:hget(hash, chat_id)
   local receiver = get_receiver(msg)
   send_large_msg(receiver, "User for SuperGroup:["..msg.to.print_name.."]\n\n > "..pass)
 end
end

return {
  patterns = {
    "^/(user) (.*)$",
    "^/(user)$",
    "^([Jj]oin) (.*)$"
  },
  run = run
}
--plugin by Thisisamirh
end
