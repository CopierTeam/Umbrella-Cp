local function get_contact_list_callback (cb_extra, success, result)
  local text = " "
  for k,v in pairs(result) do
    if v.print_name and v.id and v.phone then
      text = text..string.gsub(v.print_name ,  "_" , " ").." ["..v.id.."] = "..v.phone.."\n"
    end
  end
  local file = io.open("contact_list.txt", "w")
  file:write(text)
  file:flush()
  file:close()
  send_document("user#id"..cb_extra.target,"contact_list.txt", ok_cb, false)--.txt format
  local file = io.open("contact_list.json", "w")
  file:write(json:encode_pretty(result))
  file:flush()
  file:close()
  send_document("user#id"..cb_extra.target,"contact_list.json", ok_cb, false)--json format
end

local function get_dialog_list_callback(cb_extra, success, result)
  local text = ""
  for k,v in pairsByKeys(result) do
    if v.peer then
      if v.peer.type == "chat" then
        text = text.."group{"..v.peer.title.."}["..v.peer.id.."]("..v.peer.members_num..")"
      else
        if v.peer.print_name and v.peer.id then
          text = text.."user{"..v.peer.print_name.."}["..v.peer.id.."]"
        end
        if v.peer.username then
          text = text.."("..v.peer.username..")"
        end
        if v.peer.phone then
          text = text.."'"..v.peer.phone.."'"
        end
      end
    end
    if v.message then
      text = text..'\nlast msg >\nmsg id = '..v.message.id
      if v.message.text then
        text = text .. "\n text = "..v.message.text
      end
      if v.message.action then
        text = text.."\n"..serpent.block(v.message.action, {comment=false})
      end
      if v.message.from then
        if v.message.from.print_name then
          text = text.."\n From > \n"..string.gsub(v.message.from.print_name, "_"," ").."["..v.message.from.id.."]"
        end
        if v.message.from.username then
          text = text.."( "..v.message.from.username.." )"
        end
        if v.message.from.phone then
          text = text.."' "..v.message.from.phone.." '"
        end
      end
    end
    text = text.."\n\n"
  end
  local file = io.open("dialog_list.txt", "w")
  file:write(text)
  file:flush()
  file:close()
  send_document("user#id"..cb_extra.target,"dialog_list.txt", ok_cb, false)--.txt format
  local file = io.open("dialog_list.json", "w")
  file:write(json:encode_pretty(result))
  file:flush()
  file:close()
  send_document("user#id"..cb_extra.target,"dialog_list.json", ok_cb, false)--json format
end

local function run(msg, matches)
if matches[1]:lower() == "addcontact" and is_admin(msg) then
    phone = matches[2]
    first_name = matches[3]
    last_name = matches[4]
    add_contact(phone, first_name, last_name, ok_cb, false)
   return "User With Phone +"..matches[2].." has been added"
end

if matches[1]:lower() == "remcontact" and is_admin(msg) then
    del_contact("user#id"..matches[2], ok_cb, false)
    return "User "..matches[2].." has been removed"
end

if matches[1]:lower() == "sendcontact" and is_admin(msg) then
  phone = matches[2]
  first_name = matches[3]
  last_name = matches[4]
  send_contact(get_receiver(msg), phone, first_name, last_name, ok_cb, false)
  end
  
  if matches[1]:lower() == "mycontact" and is_sudo(msg) then
	if not msg.from.phone then
		retrurn "I must Have Your Phone Number!"
    end
    phone = msg.from.phone
    first_name = (msg.from.first_name or msg.from.phone)
    last_name = (msg.from.last_name or msg.from.id)
    send_contact(get_receiver(msg), phone, first_name, last_name, ok_cb, false)
end

if matches[1]:lower() == "contactlist" and is_admin(msg) then
 get_contact_list(get_contact_list_callback, {target = msg.from.id})
      return "I've sent contact list with both json and text format to your private"
end

if matches[1]:lower() == "dialoglist" and is_admin(msg) then
    get_dialog_list(get_dialog_list_callback, {target = msg.from.id})
      return "I've sent a group dialog list with both json and text format to your private messages"
      end

if matches[1]:lower() == "pv" then
local text = "Message From @"..(msg.from.username or msg.from.first_name).."\n\nMessage : "..matches[3]
send_large_msg("user#id"..matches[2], text)
end
end

return {
    patterns = {
    "^([Pp]v) (%d+) (.*)$",
        "^([Aa]ddcontact) (.*) (.*) (.*)$",
        "^([Rr]emcontact) (%d+)$",
        "^([Ss]endcontact) (.*) (.*) (.*)$",
        "^([Mm]ycontact)$",
        "^([Cc]ontactlist)$",
        "^([Dd]ialoglist)$",
    },
    run = run, 
}
