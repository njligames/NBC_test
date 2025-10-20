function Init() as void
    m.top.observeField("focusedChild", "onCurrentFocusedChildChanged")
    m.top.observeField("streamMetadata", "onStreamInfoChanged")
    m.buttonsBar = m.top.findNode("buttonsBar")
end function

function processMessage(message) as void
    msg = message.payload
    if msg.field = "state"
        onCurrentPlayStateChanged(msg.data)
    end if
    if msg.field = "seek"
        onCurrentPlaySeekChanged(msg.data)
    end if
    if msg.field = "position"
        onCurrentPlayPositionChanged(msg.data)
    end if
end function

function onControl(_) as void
    m.top.setField("setControl", m.buttonsBar.control)
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if press = true
        return false
    end if
    if key = "back"
        m.top.backPressed = true
        return true
    end if
    return false
end function

function onCurrentPlayStateChanged(playState) as void
    m.buttonsBar.state = playState
end function

function onCurrentPlaySeekChanged(seconds) as void
    m.buttonsBar.position = seconds
end function

function onCurrentPlayPositionChanged(seconds) as void
    m.buttonsBar.position = seconds
end function

function onCurrentFocusedChildChanged(_) as void
    m.buttonsBar.setFocus(true)
end function
