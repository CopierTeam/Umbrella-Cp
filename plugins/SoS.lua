do
 function run(msg, matches)
 
 local fuse = 'New Emergency Talking Just We Received From User #"..(msg.from.username or msg.from.id).."\nUser#ID : ['..msg.from.id..']\nName : ' .. msg.from.print_name ..'\nUsername : @' .. msg.from.username .. '\n\nLocal Emergency Message:\n\n' .. matches[1] 
 local fuses = '!printf user#id' .. msg.from.id
 
 
   local text = matches[1]
   local user = "user#id".._config.sudo_users 
   --like : local user = "user#id"..12345678
   
  local sends = send_msg(user, fuse, ok_cb, false)
  return 'Thanks For Your Emergency User['..msg.from.id..']'
 
 end
 end
 return {
  
  description = "Emergency Messages",
 
  usage = "Emergency message",
  patterns = {
  "^[Ss][Oo][Ss] (.*)$"
 
  },
  run = run
 }
