do
local function savefile(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local receiver = get_receiver(msg)
  if success then
    local file = 'cloud/'..name
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
local function saveplug(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local receiver = get_receiver(msg)
  if success then
    local file = 'plugins/'..name..'.lua'
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
local function run(msg,matches)
local receiver = get_receiver(msg)
local group = msg.to.id
    if msg.reply_id then
   local name = matches[2]
      if matches[1] == "addplug" and matches[2] and is_sudo(msg) then
load_document(msg.reply_id, saveplug, {msg=msg,name=name})
        return 'Plugin '..name..' has been saved.'
    end
end
if matches[1]:lower() == 'addplug' and is_sudo(msg) then
  local text = matches[2]
  local b = 1
  local name = matches[3]
  local file = io.open("plugins/"..name..matches[4], "w")
  file:write(text)
  file:flush()
  file:close()
  return "Done!"
  end
if matches[1]:lower() == 'send' and is_sudo(msg) then
send_document(get_receiver(msg), "plugins/"..matches[2]..".lua", ok_cb, false)
end
  if matches[1]:lower() == 'send>' and is_sudo(msg) then
 local plg = io.popen("cat plugins/"..matches[2]..".lua" ):read('*all')
  return plg
end
      if matches[1]:lower() == "save" and msg.reply_id and matches[2] and is_sudo(msg) then
	     local name = matches[2]
load_document(msg.reply_id, savefile, {msg=msg,name=name})
load_photo(msg.reply_id, savefile, {msg=msg,name=name})
load_video(msg.reply_id, savefile, {msg=msg,name=name})
load_audio(msg.reply_id, savefile, {msg=msg,name=name})
        return 'Done'
    end
end
if matches[1]:lower() == 'dl' and is_sudo(msg) then
local url = matches[2]
local file = 'cloud/'matches[3]
download_to_file(url, file)
return 'Done'
end
if matches[1]:lower() == "get" then
    local file = matches[2]
    if is_sudo(msg) then
      send_document('user#id'..msg.from.id, "cloud/"..file, ok_cb, false)
      else 
        return nil
    end
  end
if matches[1]:lower() == "get>" then 
    if is_sudo(msg) then
      send_document('chat#id'..msg.to.id, "cloud/"..matches[2], ok_cb, false)
      else 
        return nil
    end
  end
if matches[1]:lower() == "setfile" then
  local text = matches[3]
  local b = 1
  local name = matches[2]
  local file = io.open("cloud/"..name, "w")
  file:write(text)
  file:flush()
  file:close()
  return "Done!"
  end
if matches[1]:lower() == 'dir' and is_sudo(msg) then
local text = io.popen("cd cloud && ls"):read('*all')
  return text
end
if matches[1]:lower() == 'show' and is_sudo(msg) then
			if #matches == 2 then
local file = io.popen("cat cloud/"..matches[2] .." "):read('*all')
  return file
		else
	return 
end
end
end
return {
  patterns = {
"^([Aa]ddplug) (.+) (.*) (.*)$",
"^([Ss]end) (.*)$",
"^([Ss]end>) (.*)$",
"^([Aa]ddplug) (.*)$",
"^([Gg]et) (.*)",
"^([Dd]ir)",
"^([Ss]how) (.*)",
"^([Ss]ave) (.*)",
"^([Gg]et>) (.*)",
"%[(document)%]",
"%[(photo)%]",
"%[(video)%]",
"%[(audio)%]",
"^([Ss]etfile) ([^%s]+) (.*)$",
  },
  run = run
  }
  end
