local database = 'http://umbrella.shayan-soft.ir/txt/'
local function run(msg)
	local res = http.request(database.."danestani.db")
	if string.match(res, '@UmbrellaTeam') then res = string.gsub(res, '@UmbrellaTeam', "")
 end
	local joke = res:split(",")
	return joke[math.random(#joke)]
end

return {
	description = "500 Persian danestani",
	usage = "danestani : send random danestani",
	patterns = {"^[Dd]anestani$"},
	run = run
}
