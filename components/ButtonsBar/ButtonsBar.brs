function Init() as Void
    m.commandButtons = m.top.findNode("commandButtons")
    m.top.observeField("state", "onCurrentPlayStateChanged")
    m.top.observeField("position", "onCurrentPositionChanged")

    m.top.observeField("duration", "onDurationChanged")
    m.selectedIndex = 1
    m.currentSeekMultiplierDirection = 0
    m.top.currentSeek = 0
    m.top.isSeeking = false
    m.seekSize = 0
    m.seekSizeOffset = 1
end function

function onDurationChanged(event) as Void
    if m.seekSize = 0
        m.seekSize = m.top.duration
    end if
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press = true
        return false
    end if
    if NOT m.top.inAdBreak
        if key = Commands().left
            handleLeft()
        else if key = Commands().right
            handleRight()
        else if key = Commands().OK
            handleOK(key)
        end if
    end if
    if key = Commands().play
        handleResume()
    end if
    return false
end function

function redrawButtons(oldSelectedIndex) as Void
    if oldSelectedIndex = m.selectedIndex
        return
    end if
    oldCommand = m.commandButtons.getChild(oldSelectedIndex)
    oldCommand.uri = updateButtonURI(oldCommand.id, -1)

    commandButton = m.commandButtons.getChild(m.selectedIndex)
    commandButton.uri = updateButtonURI(commandButton.id, m.selectedIndex)
end function

function updateButtonURI(command, index) as String
    if command = Commands().resume AND LCase(m.top.state) = "playing"
        command = Commands().pause
    end if
    selectedStr = "selected"
    if index <> m.selectedIndex
        selectedStr = "unselected"
    end if
    return Substitute("pkg:/images/player/{0}_{1}.png", command, selectedStr)
end function

function setSelectedIndex(command) as Void
    for i = 0 to m.commandButtons.getChildCount() - 1
        commandButton = m.commandButtons.getChild(i)
        if commandButton.id = command
            m.selectedIndex = i
            return
        end if
    end for
end function

function startTimer() as Void
    if m.timerTick <> invalid
        return
    end if
    m.top.isSeeking = true
    m.timerTick = createObject("RoSGNode", "Timer")
    m.timerTick.id = "timerTick"
    m.timerTick.repeat = true
    m.timerTick.duration = 1
    m.timerTick.ObserveField("fire", "onTimerTick")
    m.timerTick.control = "start"
end function

function handleResume() as Void
    if m.top.isSeeking
        stopTimer()
        m.top.seek = m.top.currentSeek
    end if
    oldSelectedIndex = m.selectedIndex
    setSelectedIndex(Commands().resume)
    setControl()
    redrawButtons(oldSelectedIndex)
end function

function stopTimer() as Void
    if m.timerTick = invalid
        return
    end if
    m.currentSeekMultiplierValue = 1
    m.currentSeekMultiplierDirection = 1
    m.top.isSeeking = false
    m.timerTick.control = "stop"
    m.timerTick = invalid
end function

function handleOK(key) as Void
    commandButton = m.commandButtons.getChild(m.selectedIndex)
    if commandButton.id = Commands().resume
        handleResume()
    else if commandButton.id = Commands().play
        goToLive()
    else if LCase(commandButton.id) = LCase("sessionConfig")
        m.top.toggleSessionConfig = NOT m.top.toggleSessionConfig
    else
        m.top.toggleSessionInfo = NOT m.top.toggleSessionInfo
    end if
    commandButton.uri = updateButtonURI(commandButton.id, m.selectedIndex)
end function

function goToLive() as Void
    if NOT m.Islive
        return
    end if

    stopTimer()
    setSelectedIndex(Commands().resume)
    m.top.seek = m.top.duration
end function

function handleLeft() as Void
    if m.selectedIndex < 1
        return
    end if
    oldSelectedIndex = m.selectedIndex
    m.selectedIndex = m.selectedIndex - 1
    redrawButtons(oldSelectedIndex)
end function

function handleRight() as Void
    if m.selectedIndex >= (m.commandButtons.getChildCount() - 1)
        return
    end if
    nextButton = m.commandButtons.getChild(m.selectedIndex + 1)
    if nextButton.id = "play" AND NOT nextButton.visible
        return
    end if
    oldSelectedIndex = m.selectedIndex
    m.selectedIndex = m.selectedIndex + 1
    redrawButtons(oldSelectedIndex)
end function

function setControl() as Void
    control = m.commandButtons.getChild(m.selectedIndex).id
    if control = Commands().resume AND LCase(m.top.state) = "playing"
        control = Commands().pause
    end if
    m.top.control = control
end function

function onCurrentPlayStateChanged(event) as Void
    resume = m.top.findNode("resume")
    if LCase(m.top.state) = "playing"
        resume.uri = updateButtonURI(Commands().pause, 1)
        m.top.findNode("play").visible = false
        m.top.findNode("play").uri = updateButtonURI(Commands().play, -1)
        m.currentSeekMultiplierDirection = 0
    else if LCase(m.top.state) = "paused"
        resume.uri = updateButtonURI(Commands().resume, 1)
        m.top.findNode("play").visible = m.Islive
    end if
end function

function onCurrentPositionChanged(event) as Void
    m.top.currentSeek = m.top.position
    m.isSeeking = false
end function

function onTimerTick(event) as Void
    if m.timerTick.control = "stop" OR m.top.isSeeking = false
        stopTimer()
    end if
    nextSeek = m.top.currentSeek + (m.currentSeekMultiplierDirection * m.seekSizeOffset)
    if nextSeek >= 0
        m.top.currentSeek = nextSeek
    else
        m.top.currentSeek = 0
    end if
end function
