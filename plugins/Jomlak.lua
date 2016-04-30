local database = 'http://umbrella.shayan-soft.ir/txt/'
local function run(msg)
	local res = http.request(database.."jomlak.db")
	if string.match(res, '@UmbrellaTeam') then res = string.gsub(res, '@UmbrellaTeam', "")
 end
	local joke = res:split(",")
	return joke[math.random(#joke)]
end

return {
	description = "500 Persian Jomlak",
	usage = "jomlak : send random jomlak",
	patterns = {"^[Jj]omlak$"},
	run = run
}
