
do

function run(msg, matches)
  return [[ 
Umbrella-Cp Telegram Bot v1.0 
 
 Team Channel : @CopierTeam
 Owner : @Amir_h
 
 Powered by:
 #CopierTeam
 
 Special Thanks:
Allen
Reza
SeedTeam
 and more...]]
end

return {
  description = "Shows bot version", 
  usage = "ver: Shows bot version",
  patterns = {
    "^[Vv]er$"
  }, 
  run = run 
}

end
