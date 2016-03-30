local function run(msg,matches)
    if matches[1] == "help>" then
    send_document("chat#id"..msg.to.id,"./Umbrella-Cp/data/echo/Help.html", ok_cb, false)
    end
end

return {
    patterns = {
        "^([Hh]elp>)$",
    },
    run = run
    }
