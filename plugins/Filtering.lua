local function save_filter(msg, name, value)
	local hash = nil
	if msg.to.type == 'chat' then
		hash = 'chat:'..msg.to.id..':filters'
	end
	if msg.to.type == 'user' then
		return 'For Chat only'
	end
	if hash then
		redis:hset(hash, name, value)
		return "Successfull!"
	end
end

local function get_filter_hash(msg)
	if msg.to.type == 'chat' then
		return 'chat:'..msg.to.id..':filters'
	end
end 

local function list_filter(msg)
	if msg.to.type == 'user' then
		return 'For Chat only'
	end
	local hash = get_filter_hash(msg)
	if hash then
		local names = redis:hkeys(hash)
		local text = 'List Of Filtered Words For '..msg.to.title..':\n\n'
		numb = numb+1
		for i=1, #names do
			text = text..numb..'> '..names[i]..'\n'
		end
		return text
	end
end

local function get_filter(msg, var_name)
	local hash = get_filter_hash(msg)
	if hash then
		local value = redis:hget(hash, var_name)
		if value == 'msg' then
			return 'WARNING!\nDon\'nt Use it!'
		elseif value == 'kick' then
			reply_msg(msg.id, "You Used An Filtered Word\nUser "..(msg.from.first_name or msg.from.last_name).." ["..msg.from.id.."]\nStatus : User Kicked")
						chat_del_user('chat#id'..msg.to.id, 'user#id'..msg.from.id, ok_cb, false)
		end
	end
end

local function get_filter_act(msg, var_name)
	local hash = get_filter_hash(msg)
	if hash then
		local value = redis:hget(hash, var_name)
		if value == 'msg' then
			return 'If You Use It You Will Get Warn!'
		elseif value == 'kick' then
			return 'If You Use it You Will Get Kicked!'
		elseif value == 'none' then
			return 'This Word Is Not In Filter List'
		end
	end
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
	if matches[1] == "ilterlist" then
		return list_filter(msg)
	elseif matches[1] == "ilter" and matches[2] == "warn" then
		if data[tostring(msg.to.id)] then
			local settings = data[tostring(msg.to.id)]['settings']
			if not is_momod(msg) then
				return "You Are Not an Moderator"
			else
				local value = 'msg'
				local name = string.sub(matches[3]:lower(), 1, 1000)
				local text = save_filter(msg, name, value)
				return text
			end
		end
	elseif matches[1] == "ilter" and matches[2] == "+" then
		if data[tostring(msg.to.id)] then
			local settings = data[tostring(msg.to.id)]['settings']
			if not is_momod(msg) then
				return "You Are Not Moderator"
			else
				local value = 'kick'
				local name = string.sub(matches[3]:lower(), 1, 1000)
				local text = save_filter(msg, name, value)
				return text
			end
		end
	elseif matches[1] == "ilter" and matches[2] == "-" then
		if data[tostring(msg.to.id)] then
			local settings = data[tostring(msg.to.id)]['settings']
			if not is_momod(msg) then
				return "You Are Not Moderator"
			else
				local value = 'none'
				local name = string.sub(matches[3]:lower(), 1, 1000)
				local text = save_filter(msg, name, value)
				return text
			end
		end
		
			elseif matches[1] == "ilter" and matches[2] == "clean" then
		if data[tostring(msg.to.id)] then
			local settings = data[tostring(msg.to.id)]['settings']
			if not is_momod(msg) then
				return "For Moderatiors Only"
			else
				local value = 'none'
				local name = string.sub(matches[3]:lower(), 1, 1000)
				local text = save_filter(msg, name, value)
				return text
			end
		end
		
	elseif matches[1] == "ilter" and matches[2] == ">" then
		return get_filter_act(msg, matches[3]:lower())
	else
		if is_sudo(msg) then
			return
		elseif is_admin(msg) then
			return
		elseif is_momod(msg) then
			return
		elseif tonumber(msg.from.id) == tonumber(our_id) then
			return
		else
			return get_filter(msg, msg.text:lower())
		end
	end
end

return {
	patterns = {
		"^[Ff](ilter) (.+) (.*)$",
		"^[Ff](ilterlist)$",
		"(.*)",
	},
	run = run
}
