do

local function run(msg, matches)
  local id = msg.to.id
if matches[1]:lower() == "gplist" then
local text = 'لیست گروه هایی که میتوانید در آنها عضو شوید : \n'
local name = redis:hkeys("passes")
for i=1,#name do
text = text..i..'- '..name[i]..'\n'
end
return text
end
  if matches[1]:lower() == "/user" and msg.to.type == "chat" and matches[2] and is_owner(msg) then
    local pass = matches[2]:lower()
    if redis:hget('passes',pass) then
      return "یوزر "..matches[2].."برای این گروه تنظیم شد\nاز این به  بعد کاربران میتوانند با ارسال دستور زیر وارد گروه شوند \njoin "..matches[2]
    end
local nowpass = redis:hget('setpass',msg.to.id)
if nowpass then
redis:hdel('passes',nowpass)
end
redis:hset('setpass',msg.to.id,pass)
redis:hset('passes',pass,msg.to.id)
local name = string.gsub(msg.to.print_name, '_', '')
     send_large_msg("chat#id"..msg.to.id, "یوزر "..matches[2].." برای این گروه تنظیم شد\nاز این به  بعد کاربران میتوانند با ارسال دستور زیر وارد گروه شوند \njoin "..matches[2], ok_cb, true)
    return
  end
  if matches[1]:lower() == "join" and matches[2] then
    local hash = 'passes'
    local pass = matches[2]:lower()
    id = redis:hget(hash, pass)
    local receiver = get_receiver(msg)
    if not id then
      return "گروهی با این یوزر وجود ندارد"
    end
  if data[tostring(id)] then
  if is_banned(msg.from.id, id) then
      return 'شما از این گروه بن هستید'
   end
      if is_gbanned(msg.from.id) then
            return 'شما سوپر بن هستید'
      end
      if data[tostring(id)]['settings']['lock_member'] == 'yes' and not is_owner2(msg.from.id, id) then
        return 'گروه خصوصی است'
      end
    end
    chat_add_user("chat#id"..id, "user#id"..msg.from.id, ok_cb, false) 
  return 'به گروه '..pass..' اضافه شدید!'
  end
  if matches[1]:lower() == "user" then
if not msg.to.type == 'chat' then
return 'فقط در گروه ها'
end
   local hash = 'setpass'
   local pass = redis:hget(hash,msg.to.id)
   local receiver = get_receiver(msg)
   send_large_msg(receiver, "یوزر گروه [ "..msg.to.print_name.." ] :\n\n > "..pass)
 end
end

return {
  patterns = {
    "^(/[Uu]ser) (.*)$",
    "^([Uu]ser)$",
    "^([Gg]plist)$",
    "^([Jj]oin) (.*)$",
  },
  run = run
}
end      
