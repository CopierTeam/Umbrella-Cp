do

local function run(msg, matches)
if is_admin(msg) then
 local user = matches[2]
  if matches[1] == "+" then
      user = 'user#id'..user
      block_user(user, ok_cb, false)
    return "یوزر ["..matches[2].."] بلاک شد"
  end
if matches[1] == "-" then
user = "user#id"..matches[2]
unblock_user(user, ok_cb, false)
return "یوزر ["..matches[2].."] انبلاک شد"
end
end
end

return {
description = "بلاک یا انبلاک کردن از پی وی",
usage = "Block [+/-] [User-ID] : بلاک یا انبلاک کردن از پی وی",
  patterns = {
    "^[Bb]lock (+) (%d+)$",
    "^[Bb]lock (-) (%d+)$",
  },
  run = run,
}
