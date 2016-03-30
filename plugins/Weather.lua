do

local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"

local function get_weather(location)
  print("Finding weather in ", location)
  local url = BASE_URL
  url = url..'?q='..location..'&APPID=5f5d8da1984bd84dcff8ee7cb1abebb5'
  url = url..'&units=metric'

  local b, c, h = http.request(url)
  if c ~= 200 then return nil end

  local weather = json:decode(b)
  local city = weather.name
  local country = weather.sys.country
  local temp = 'همینک آب و هوا در'..city
    ..' (' ..country..')'
    ..'\n\n'..weather.main.temp..'درجه سانتی گراد'
  local conditions = 'وضعیت آب و هوا : '
    .. weather.weather[1].description
  
  if weather.weather[1].main == 'Clear' then
    conditions = conditions .. ' ☀'
  elseif weather.weather[1].main == 'Clouds' then
    conditions = conditions .. ' ☁☁'
  elseif weather.weather[1].main == 'Rain' then
    conditions = conditions .. ' ☔'
  elseif weather.weather[1].main == 'Thunderstorm' then
    conditions = conditions .. ' ☔☔☔☔'
  end

  return temp .. '\n' .. conditions
end

local function run(msg, matches)
  local city = 'Tehran'

  if matches[1] ~= 'weather' then 
    city = matches[1]
  end
  local text = get_weather(city)
  if not text then
    text = 'مکان وارد شده صحیح نیست'
  end
  return text
end

return {
  description = "weather in that city (Tehran is default)", 
  usage = "weather (city)",
  patterns = {
    "^[Ww]eather$",
    "^[Ww]eather (.*)$"
  }, 
  run = run 
}

end
