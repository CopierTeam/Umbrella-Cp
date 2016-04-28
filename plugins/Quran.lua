do
umbrella_cp = "http://umbrella.shayan-soft.ir/quran/"


local function read_sura(chat_id, target)
local readq = http.request(umbrella_cp.."Sura"..target..".mp3")
local url = umbrella_cp.."Sura"..target..".mp3"
local file = download_to_file(url, umbrella_cp.mp3)
send_document("chat#id"..chat_id, file, ok_cb, false)
end


local function view_sura(chat_id, target)
local viewq = http.request(umbrella_cp.."quran ("..target..").txt")
viewq = string.gsub(viewq, "@UmbrellaTeam", " ")
viewq = string.gsub(viewq, " K  ", "@ ")
return viewq
end

local function run(msg, matches)
    local chat_id = msg.to.id
if matches[1] == "ead" then
local target = matches[2]
return read_sura(chat_id, target)
elseif matches[1] == "ura" then
local target = matches[2]
return view_sura(chat_id, target)
elseif matches [1] == "uran" then
local qlist = http.request(umbrella_cp.."list.txt") 
qlist = string.gsub(qlist, "@UmbrellaTeam", "@CopierTeam")
return qlist
end
end

return {
description = "umbrella_cp Quran Project", 
usage = {
"sura (num) : view arabic sura",
"read (num) : send sound of sura",
"quran : sura list of quran",
},
patterns = {
"^[Ss](ura) (.+)$",
"^[Rr](ead) (.+)$",
"^[Qq](uran)$",
}, 
run = run,
}

end
