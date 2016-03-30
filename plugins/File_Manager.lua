local function run(msg, matches)
  if matches[1] == "send" and is_admin(msg) then
    local file = matches[3]
    local fulder = matches[2]
      local receiver = get_receiver(msg)
      send_document(receiver, "./fulder/"..file..".lua", ok_cb, false)
    end
  end
if matches[1] == 'addplug' and is_sudo(msg) then
  local text = matches[2]
  local b = 1
  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local name = matches[3]
  local file = io.open("./plugins/"..name..matches[4], "w")
  file:write(text)
  file:flush()
  file:close()
  return "done"
  end
  return {
  patterns = {
  "^([Ss]end) (.*)/(.*)$",
  "^([Aa]ddplug)(.+) (.*) (.*)$"
  },
  run = run
}
end
