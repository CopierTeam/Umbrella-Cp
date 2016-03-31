local jocks_file = './data/jokes.lua'
local jocks_table

function read_jocks_file()
    local f = io.open(jocks_file, "r+")

    if f == nil then
        print ('Created a new jocks file on '..jocks_file)
        serialize_to_file({}, jocks_file)
    else
        print ('Quotes loaded: '..jocks_file)
        f:close()
    end
    return loadfile (jocks_file)()
end

function save_jock(msg)
    local to_id = tostring(msg.to.id)

    if msg.text:sub(11):isempty() then
        return "Usage: addjock jock"
    end

    if jocks_table == nil then
        jocks_table = {}
    end

    if jocks_table[to_id] == nil then
        print ('New jock key to_id: '..to_id)
        jocks_table[to_id] = {}
    end

    local jocks = jocks_table[to_id]
    jocks[#jocks+1] = msg.text:sub(11)

    serialize_to_file(jocks_table, jocks_file)

    return "done!"
end

function get_jock(msg)
    local to_id = tostring(msg.to.id)
    local jocks_phrases

    jocks_table = read_jocks_file()
    jocks_phrases = jocks_table[to_id]

    return jocks_phrases[math.random(1,#jocks_phrases)]
end

function run(msg, matches)
    if string.match(msg.text, "jock$") then
        return get_jock(msg)
    elseif string.match(msg.text, "addjock (.+)$") then
        jocks_table = read_jocks_file()
        return save_jock(msg)
    end
end

return {
    usage = {
        "addjock [msg]",
        "jock",
    },
    patterns = {
        "^[Aa]ddjock (.+)$",
        "^[Jj]ock$",
    },
    run = run
}
