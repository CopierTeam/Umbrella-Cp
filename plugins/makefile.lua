local function run(msg, matches)
 local text = matches[2]
 if matches[1] == "cho" then
  return text
 else
  local file = io.open("./echo/"..matches[1], "w")
  file:write(text)
  file:flush()
  file:close()
  return send_document("channel#id"..msg.to.id,"./plugins/"..matches[1], ok_cb, false)
 end
end

return {
 description = "Simplest plugin ever!",
 usage = {
  "!echo [text] : return text",
  "Echo> [ext] [text] : save text to file",
 },
 patterns = {
  "^[!/](echo) (.*)$",
  "^[Ee]cho> ([^%s]+) (.*)$",
 },
 run = run,
privileged = true,
}
