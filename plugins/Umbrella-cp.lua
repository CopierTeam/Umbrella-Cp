do
local function admin_list(msg)
    local data = load_data(_config.moderation.data)
        local admins = 'admins'
        if not data[tostring(admins)] then
        data[tostring(admins)] = {}
        save_data(_config.moderation.data, data)
        end
        local message = 'Admins :\n'
        for k,v in pairs(data[tostring(admins)]) do
                message = message .. '> @' .. v .. ' [' .. k .. '] ' ..'\n'
        end
        return message
end
local function run(msg, matches)
local uptime = io.popen('uptime'):read('*all')
local admins = admin_list(msg)
local data = load_data(_config.moderation.data)
local group_link = data[tostring(113090136)]['settings']['set_link'] --put your support id here
local github = 'github.com/CopierTeam/Umbrella-Cp'
local space = '______________________________'
if not group_link then
return ''
end
return "مشحصات فنی سرور\n مدت آنلاین :"..uptime.."\nMacintosh A9 Procesor\nCPU : 16 Core\nRAM : 32 GB\nHDD : 2 x 4 TB\nIPN : 7 MB/S\nPort : 2 MB/s\n"..space.."\nگیتهاب Umbrella-Cp :\n"..github.."\n توسئه دهندگان :\nسازنده و صاحب امتیاز: #CopierTeam\n"..admins.."\n"..space.."\nپلهای ارتباطی :\nکانال : https://telegram.me/CopierTeam\n لینک ساپورت :\n"..group_link
end
return {
patterns = {
"^[Uu]mbrella$",
},
run = run
}
end
