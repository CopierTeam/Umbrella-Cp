do
function run(msg, matches)
local url , res = http.request('http://api.gpmod.ir/time/')
if res ~= 200 then return "No connection" end
local jdat = json:decode(url)
local text = jdat.FAdate..'\n'..jdat.ENdate
return text
end
return {
  patterns = {
  "^([Dd]ate)$"
  }, 
run = run 
} 
end
