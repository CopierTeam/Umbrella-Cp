do
local function user_print_name(user)
   if user.print_name then
      return user.print_name
   end
   local text = ''
   if user.first_name then
      text = user.last_name..' '
   end
   if user.lastname then
      text = text..user.last_name
   end
   return text
end

local function returnids(cb_extra, success, result)
   local receiver = cb_extra.receiver
   --local chat_id = "chat#id"..result.id
   local chat_id = result.id
   local chatname = result.print_name

   local text = 'نام گروه: '..chatname..' ایدی: '..chat_id..'تعداد اعضا: '..result.members_num..'\n______________________________\n'
      i = 0
   for k,v in pairs(result.members) do
      i = i+1
      text = text .. i .. "> " .. string.gsub(v.print_name, "_", " ") .. " (" .. v.id .. ")\n"
   end
   send_large_msg(receiver, text)
end

local function username_id(cb_extra, success, result)
   local receiver = cb_extra.receiver
   local qusername = cb_extra.qusername
   local text = 'No '..qusername..' in group'
   for k,v in pairs(result.members) do
      vusername = v.username
      if vusername == qusername then
      	text = 'Username: @'..vusername..'\nID Number: '..v.id
      end
   end
   send_large_msg(receiver, text)
end
local function run(msg, matches)
 if matches[1]:lower() == 'id' then
    if msg.to.type == "user" then
      return "Bot ID: "..msg.to.id.. "\nYour ID: "..msg.from.id
    end
    if type(msg.reply_id) ~= "nil" then
      local name = user_print_name(msg.from)
        savelog(msg.to.id, name.." ["..msg.from.id.."] used /id ")
        id = get_message(msg.reply_id,get_message_callback_id, false)
    elseif matches[1]:lower() == 'id' or matches[1]:lower() == 'id gp' then
      local name = user_print_name(msg.from)
      savelog(msg.to.id, name.." ["..msg.from.id.."] used /id ")
      return " "..msg.to.id  
    end
    elseif matches[1]:lower() == 'id me' then
      return " "..msg.from.id  
    end
end
local function run(msg, matches)
   local receiver = get_receiver(msg)
      if matches[1] == "id" and matches[2] == 'all>' then
      -- !ids? (chat) (%d+)
         local chat = 'chat#id'..matches[3]
         chat_info(chat, returnids, {receiver=receiver})
      else
         if not is_chat_msg(msg) then
            return "Only work in group"
         end
         local chat = get_receiver(msg)
         chat_info(chat, returnids, {receiver=receiver})
      end
   else
   	if not is_chat_msg(msg) then
   		return "Only work in group"
   	end
   	local qusername = string.gsub(matches[1], "@", "")
   	local chat = get_receiver(msg)
   	chat_info(chat, username_id, {receiver=receiver, qusername=qusername})
   end
return {
   patterns = {
      "^([Ii]d)$",
      "^([Ii]d gp)$",
      "^([Ii]d me)$",
      "^[Ii]d (.*)$",
	  "^([Ii]d) (all>)$",
   },
   run = run
}
end
