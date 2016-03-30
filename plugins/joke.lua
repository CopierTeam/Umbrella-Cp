local  = load_from_file('joke_data.lua')
local function run(msg)
return joke[math.random(#joke)]
end

return {
description = "500 Persian Joke",
usage = "!joke : send random joke",
patterns = {"^[Jj]oke$"},
run = run
}
