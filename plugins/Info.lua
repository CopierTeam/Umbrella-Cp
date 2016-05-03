do

function run(msg, matches)
if msg.text == "Info" then
          return   "نام کامل: "..(msg.from.print_name or '').."\nنام کوچک: "..(msg.from.first_name or '').."\nنام خانوادگی: "..(msg.from.last_name or '').."\n\nشماره موبایل: +"..(msg.from.phone or '').."\nیوزرنیم: @"..(msg.from.username or '').."\nآی دی: "..msg.from.id.."\nرابط کاربری: موبایل\nنام گروه: "..msg.to.title.."\nآی دی گروه: 
"..msg.to.id.."\n#Cper"
eseif msg.text == "info" then
               return   "نام کامل: "..(msg.from.print_name or '').."\nنام کوچک: "..(msg.from.first_name or '').."\nنام خانوادگی: "..(msg.from.last_name or '').."\n\nشماره موبایل: +"..(msg.from.phone or '').."\nیوزرنیم: @"..(msg.from.username or '').."\nآی دی: "..msg.from.id.."\nرابط کاربری: کامپیوتر\nنام گروه: "..msg.to.title.."\nآی دی گروه: 
"..msg.to.id.."\n#Cper"           
end
return {
  description = "", 
  usage = "",
  patterns = {
    "^Info$",
    "^info$",
  },
  run = run
}
end
--by Shahabsaf @ShahabHiDDeN
--will be update soon!
