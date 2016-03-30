do

local function run(msg, matches)
  local eq = URL.escape(matches[1])

  local url = "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&q="..eq.."&tl=En-gb"
  local receiver = get_receiver(msg)
  send_audio_from_url(receiver, url, send_title, {receiver, title})
end

return {
  description = "Convert text to voice",
  usage = {
    "tts [text]: Convert text to voice"
  },
  patterns = {
    "^[Tt]ts (.+)$"
  },
  run = run
}

end
--plugin by mehrpouya
