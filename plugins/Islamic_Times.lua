function fsize(file)
      local cfile = io.open(file,"r")
      local current = cfile:seek()    
      local size = cfile:seek("end")   
      cfile:seek("set", current)       
      cfile:close()
      return size/1000
 end
local function run(msg, matches)
  local res = http.request("http://muslimsalat.com/"..URL.escape(matches[2])..".json?key=0c67a5121190c05e9e09d83f3af2cb3a")
  local jtab = JSON.decode(res)
  if jtab.country then
    local gheble = tonumber(jtab.qibla_direction)
    local url = 'http://muslimsalat.com/qibla_compass/200/'..gheble..'.png'
    local url2 = "http://www.qiblaway.com/images/compass-arrows/"..gheble..".png"
    local file = download_to_file(url, 'gheble.webp')
    if fsize(file) < 1 then
    file = download_to_file(url2, 'gheble.webp')
    end
  local ghebleh = send_document(get_receiver(msg), file, ok_cb, false)
if not file then
   ghebleh = ""
   end
 local text = "موقعیت مکانی:\n"..jtab.country..", "..jtab.state..", "..(jtab.city or "").." ("..jtab.latitude..","..jtab.longitude..")\n\n"
    .."اذان صبح: "..jtab.items[1].fajr.."\n"
    .."طلوع خورشید: "..jtab.items[1].shurooq.."\n"
    .."اذان ظهر: "..jtab.items[1].dhuhr.."\n"
    .."نماز عصر: "..jtab.items[1].asr.."\n"
    .."اذان مغرب: "..jtab.items[1].maghrib.."\n"
    .."نماز عشا: "..jtab.items[1].isha.."\nقبله:"
.." (اگر استیکر ارسال نشد یعنی جهت قبله در دیتابیس موجود نیست)"
  send_large_msg(get_receiver(msg), text, ok_cb, false)
return ghebleh
else
    return "مکان وارد شده صحیح نیست"
  end
end

return {
  description = "Islamic Times",
  usagehtm = '<tr><td align="center">azan شهر</td><td align="right">نمایش اوقات شرعی شهرهای ایران. میتوانید نام شهر را لاتین یا فارسی وارد کنید</td></tr>',
  usage = {"azan (city) : اوقات شرعی"},
  patterns = {"^([Aa]zan) (.*)$"},
  run = run,
}      
