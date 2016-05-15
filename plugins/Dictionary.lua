local function run(msg, matches)
local txt , lang = '' , 'fa'
if matches[1]:lower() == 'dic,' then
txt = matches[3]:lower()
lang = matches[2]:lower()
end
if matches[1]:lower() == 'dic' then
txt = matches[2]:lower()
end
local htp = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..lang..'&text='..txt)
local data = json:decode(htp)
return data.text[1]
end
return {
  patterns = {
    "^([Dd]ic,) ([^%s]+) (.*)$",
  "^([Dd]ic) (.*)$"
  },
  run = run
}
