local function run(msg, matches)
  if matches[1]:lower() == "config" then
    local data = http.request("http://ip-api.com/json/"..URL.escape(matches[2]).."?fields=262143")
    local jdat = JSON.decode(data)
    if jdat.status == "success" then
      local text = "مشخصات آی اس پی شخص-دامنه مورد نظر:\n"
      .."کشور: "..jdat.country.." - "..jdat.countryCode.."\n"
      .."استان: "..jdat.regionName.."\n"
      .."شهر: "..jdat.city.."\n"
      .."زیپ کد: "..jdat.zip.."\n"
      .."تایم زون: "..jdat.timezone.."\n"
      .."مختصات جغرافیایی: "..jdat.lat..","..jdat.lon.."\n"
      .."لینک گوگل مپ:\nhttps://www.google.com/maps/place/"..jdat.lat..","..jdat.lon.."\n"
      .."شمار موبایل: "..(jdat.mobile or "-------").."\n"
      .."آی پی پروکسی: "..(jdat.proxy or "-------").."\n"
      .."آی پی: "..jdat.query.."\n"
      .."اورگانیزیشن: "..jdat.org.."\n"
      .."آی اس پی: "..jdat.isp.."\n"
      .."آی اس: "..jdat.as
      send_location(get_receiver(msg), jdat.lat, jdat.lon, ok_cb, false)
      return text
    else
      return "مقدار وارد شد صحیح نیست"
    end
  elseif matches[1]:lower() == "ping" then
    if matches[2] == "." then
      return "64 bytes from 212.33.207.97: icmp_seq=1 ttl=48 time=107 ms"
    else
      local cmd = io.popen("ping -c1 "..matches[2]):read('*all')
      if cmd == nil or cmd == "" or not cmd then
        return "مقدار وارد شد صحیح نیست"
      else
        local char1 = cmd:find('data.')+5
        local char2 = cmd:find('\n\n')
        local text = cmd:sub(char1, char2)
        local text = text:gsub(": ", "\n")
        return text
      end
    end
  elseif matches[1]:lower() == "whois" then
    return io.popen("whois "..matches[2]):read('*all')
  elseif matches[1]:lower() == "ip" then
    return "براي مشاهده ي آي پي خود به لينک زير مراجعه کنيد\nhttp://umbrella.shayan-soft.ir/ip"
  elseif matches[1]:lower() == "getip" then
    if not matches[2] then
      return 'آدرس زیر را به شخص مورد نظر بدهید و از او بخواهید وارد آن شود و توکن را با روش مهندسی اجتماعی (گول زدن شخص) از ایشان بگیرید و با یک فاصله با همین دستور وارد کنید تا آی پی وی را ببینید\nhttp://umbrella.shayan-soft.ir/get'
    else
      local getip = http.request("http://umbrella.shayan-soft.ir/get/umbrella"..matches[2]..".config")
      if getip == "not found" then
        return "توکن وارد شده صحیح نیست"
      else
        return "آی پی شخص مورد نظر:\n"..getip
      end
    end
  end
end

return {
  description = "IP and URL Information", 
  usagehtm = '<tr><td align="center">ip</td><td align="right">لینکی در اختیارتان قرار میدهد که با ورود به آن میتوانید آی پی خود را مشاهده کنید</td></tr>'
  ..'<tr><td align="center">getip</td><td align="right">لینک ارائه شده را به شخص مورد نظر بدهید و از آن توکنی که سایت به او میدهد را بخواهید. اگر آن توکن را با یک فاصله بعد از همین دستور وارد کنید، آی پی شخص مورد نظر نمایش داده میشد<br>http://umbrella.shayan-soft.ir/get</td></tr>'
  ..'<tr><td align="center">config آی پی یا لینک</td><td align="right">اطلاعاتی کلی راجع به آن لینک یا آی پی در اختیارتان قرار میدهد. دقت کنید لینک بدون اچ تی تی پی وارد شود</td></tr>'
  ..'<tr><td align="center">ping  آی پی یا لینک</td><td align="right">از سرور با پورت های مختلف پینگ میگیرد. دقت کنید لینک بدون اچ تی تی پی وارد شود</td></tr>'
  ..'<tr><td align="center">whois لینک</td><td align="right">یک دامین را بررسی میکند و در صورتی که قبلا به ثبت رسیده باشد، مشخصات ثبت کننده را به اطلاع شما میرسان. دقت کنید لینک بدون اچ تی تی پی وارد شود</td></tr>',
  usage = {
    "ip : آي پي شما",
    "getip : دریافت و ذخیره آی پی دیگران",
    "getip (token) : نمایش ذخیره شده",
    "config (ip|url) : مشخصات",
    "ping (ip|url) : پينگ",
    "whois (url) : بررسي دامنه",
  },
  patterns = {
    "^([Ii]p)$",
    "^([Gg]etip) (.*)$",
    "^([Gg]etip)$",
    "^([Cc]onfig) (.*)$",
    "^([Pp]ing) (.*)$",
    "^([Ww]hois) (.*)$",
  }, 
  run = run
}
