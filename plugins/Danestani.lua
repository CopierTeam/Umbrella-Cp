local database = 'http://umbrella.shayan-soft.ir/txt/'
local function run(msg)
	local res = http.request(database.."danestani.db")
	if string.match(res, '@UmbrellaTeam') then res = string.gsub(res, '@UmbrellaTeam', "")
 end
	local danestani = res:split(",")
	return danestani[math.random(#danestani)]
end

return {
	description = "500 Persian danestani",
	usage = "danestani : send random danestani",
	patterns = {"^[Dd]anestani$"},
	run = run
}
