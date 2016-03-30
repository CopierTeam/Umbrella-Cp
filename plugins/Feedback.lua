do
 function run(msg, matches)
 
 local fuse = 'New FeedBack\nId : ' .. msg.from.id .. '\nName: ' .. msg.from.print_name ..'\nUsername: @' .. msg.from.username .. '\n\nThe Pm:\n' .. matches[1] 
 local fuses = '!printf user#id' .. msg.from.id
 
 
   local text = matches[1]
   local chat = "chat#id"..YourChatId 
   --like : local chat = "chat#id"..12345678
   
  local sends = send_msg(chat, fuse, ok_cb, false)
  return 'Sent!'
 
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
