local function run(msg, matches)
	local base = "curl 'https://person.clearbit.com/v1/people/email/"..matches[1].."' -u 3986c574e76b9b21094c695606f8f76e:"
	local data = io.popen(base):read('*all')
	local jdat = JSON.decode(data)
	if not jdat.name then
		return "آدرس ایمیل وارد شده صحیح نیست. آدرس ایمیل را به صورت زیر وارد کنید:\nadmin@umbrella-cp.ir.tn"
	end
	if jdat.avatar then
		send_photo_from_url("chat#id"..msg.to.id, jdat.avatar)
	end
	return "نام کامل: "..(jdat.name.fullName or "-----").."\n"
		.."نام: "..(jdat.name.givenName or "-----").."\n"
		.."فامیل: "..(jdat.name.familyName or "-----").."\n"
		.."جنسیت: "..(jdat.gender or "-----").."\n"
		.."موقعیت مکانی: "..(jdat.geo.country or "").."  "..(jdat.geo.state or "").."  "..(jdat.geo.city or "").."\n"
		.."وبسایت: "..(jdat.site or "-----").."\n"
		.."بیوگرافی:\n".. (jdat.bio or "-----")
end

return {
	description = "E-Mail Information Grabber",
	usagehtm = '<tr><td align="center">email آدرس ایمیل</td><td align="right">مشخصات صاحب ایمیل را به شما میدهد</td></tr>',
	usage = {"email (mail) : مشخصات ایمیل",},
	patterns = {"^[Ee]mail (.*)",},
	run = run
}
