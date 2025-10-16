function Init()
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then return true
    if key = "back"
        m.top.backPressed = true
    end if
    return true
end function
