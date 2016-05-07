do
local TIME_CHECK = 60
local function pre_process(msg)
  local hash = 'per_sec'
  local get = tonumber(redis:get(hash) or 0)
  redis:setex(hash, TIME_CHECK, get)
  return msg
end
local function run(msg, matches)
  if matches[1] == "me" then
    if msg.to.type == "user" then
      return msg
    end
    local hash = 'msgs:'..msg.from.id..':'..msg.to.id
	local msgsend = redis:get(hash)
	local r = tonumber(redis:get('cis_msg:'..msg.to.id))
	local t = r * 100
	local percent = math.floor((msgsend) / r * 100)
	return reply_msg(msg.id, msg.from.print_name.." You've sent "..msgsend.."("..percent.."%) and this group has "..r.." messages", ok_cb, true)
  end
  if matches[1] == "botload" and is_admin(msg) then
    local hash = 'total:msg'
    local get = tonumber(redis:get(hash))
    local per_sec = tonumber(redis:get('per_sec'))
    return per_sec.." msgs/s\n"..get.." Message since last restart"
  end
  if matches[1] == "restart" and is_sudo(msg) then
    local hash = 'total:msg'
    redis:del(hash)
    return "See ya later =)"
  end 
end

return {
  patterns = {
    "^[/!#](me)$",
    "^[/!#](botload)$",
    "^[/!#](restart)$",
  },
  run = run,
  pre_process = pre_process
}

end
