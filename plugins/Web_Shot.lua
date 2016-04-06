do

local function run(msg, matches)
  local eq = URL.escape(matches[1])

  local url = "http://api.screenshotmachine.com/?key=b645b8&size=NMOB&url="..eq

  local receiver = get_receiver(msg)
  send_photo_from_url(receiver, url, send_title, {receiver, title})
end

return {
  patterns = {
    "^[Ww]eb (.+)$"
  },
  run = run
}

end
--plugin by mehrpouya
