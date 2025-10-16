function Init() as Void
    m.top.observeField("focusedChild", "onCurrentFocusedChildChanged")
    m.top.observeField("streamMetadata", "onStreamInfoChanged")
    m.buttonsBar = m.top.findNode("buttonsBar")
end function

function processMessage(message) as Void
    msg = message.payload
    if msg.field = "state"
        onCurrentPlayStateChanged(msg.data)
    end if
end function

function onControl(event) as Void
    m.top.setField("setControl", m.buttonsBar.control)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press = true
        return false
    end if
    if key = "back"
        return true
    end if
    return false
end function

function onCurrentPlayStateChanged(playState) as Void
    m.buttonsBar.state = playState
end function

function onCurrentFocusedChildChanged(focusedChild) as void
    m.buttonsBar.setFocus(true)
end function
