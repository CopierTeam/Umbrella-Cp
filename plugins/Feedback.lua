do
 function run(msg, matches)
 
 local fuse = 'New FeedBack Just We Received From User "..(msg.from.username or msg.from.id).."\nUser#ID : ['..msg.from.id..']\nName : ' .. msg.from.print_name ..'\nUsername : @' .. msg.from.username .. '\n\nLocal Message:\n\n' .. matches[1] 
 local fuses = '!printf user#id' .. msg.from.id
 
 
   local text = matches[1]
   local chat = "chat#id"..YourChatId 
   --like : local chat = "chat#id"..12345678
   
  local sends = send_msg(chat, fuse, ok_cb, false)
  return 'Thanks For Your Feedback User['..msg.from.id..']'
 
 end
 end
 return {
  
  description = "Feedback",
 
  usage = "feedback message",
  patterns = {
  "^[Ff]eedback (.*)$"
 
  },
  run = run
 }
