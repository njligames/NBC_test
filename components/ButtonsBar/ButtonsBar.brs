function Init() as void
    m.commandButtons = m.top.findNode("commandButtons")
    m.top.observeField("state", "onCurrentPlayStateChanged")
    m.top.observeField("position", "onCurrentPositionChanged")
    m.top.observeField("control", "onCurrentControlChanged")
    m.top.observeField("currentSeek", "onCurrentSeekChanged")
    m.top.observeField("duration", "onDurationChanged")
    m.selectedIndex = 1
    m.currentSeekMultiplierDirection = 0
    m.top.currentSeek = 0
    m.top.isSeeking = false
    m.seekSize = 0
    m.seekSizeOffset = 1
end function

function onDurationChanged(_) as void
    if m.seekSize = 0
        m.seekSize = m.top.duration
    end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if press = true
        return false
    end if
    if not m.top.inAdBreak
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
    else if key = Commands().fastforward
        handleFastForward()
    else if key = Commands().rewind
        handleRewind()
    end if
    return false
end function

function redrawButtons(oldSelectedIndex) as void
    if oldSelectedIndex = m.selectedIndex
        return
    end if
    oldCommand = m.commandButtons.getChild(oldSelectedIndex)
    oldCommand.uri = updateButtonURI(oldCommand.id, -1)

    commandButton = m.commandButtons.getChild(m.selectedIndex)
    commandButton.uri = updateButtonURI(commandButton.id, m.selectedIndex)
end function

function updateButtonURI(command, index) as string
    if command = Commands().resume and LCase(m.top.state) = "playing"
        command = Commands().pause
    end if
    selectedStr = "selected"
    if index <> m.selectedIndex
        selectedStr = "unselected"
    end if
    return Substitute("pkg:/images/player/{0}_{1}.png", command, selectedStr)
end function

function setSelectedIndex(command) as void
    for i = 0 to m.commandButtons.getChildCount() - 1
        commandButton = m.commandButtons.getChild(i)
        if commandButton.id = command
            m.selectedIndex = i
            return
        end if
    end for
end function

function startTimer() as void
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

function handleResume() as void
    if m.top.isSeeking
        stopTimer()
        m.top.seek = m.top.currentSeek
    end if
    oldSelectedIndex = m.selectedIndex
    setSelectedIndex(Commands().resume)
    setControl()
    redrawButtons(oldSelectedIndex)
end function

function handleFastForward() as void
    if m.top.isSeeking
        handleResume()
    else
        m.top.control = Commands().pause

        startTimer()

        oldSelectedIndex = m.selectedIndex
        setSelectedIndex(Commands().fastforward)
        setControl()
        redrawButtons(oldSelectedIndex)
    end if
end function

function handleRewind() as void
    if m.top.isSeeking
        handleResume()
    else
        m.top.control = Commands().pause

        startTimer()

        oldSelectedIndex = m.selectedIndex
        setSelectedIndex(Commands().rewind)
        setControl()
        redrawButtons(oldSelectedIndex)
    end if
end function

function stopTimer() as void
    if m.timerTick = invalid
        return
    end if
    m.currentSeekMultiplierValue = 1
    m.currentSeekMultiplierDirection = 1
    m.top.isSeeking = false
    m.timerTick.control = "stop"
    m.timerTick = invalid
end function

function handleOK(_) as void
    commandButton = m.commandButtons.getChild(m.selectedIndex)
    if commandButton.id = Commands().resume
        handleResume()
    else if commandButton.id = Commands().play
        goToLive()
    else if commandButton.id = Commands().fastforward
        handleFastForward()
    else if commandButton.id = Commands().rewind
        handleRewind()
    else if LCase(commandButton.id) = LCase("sessionConfig")
        m.top.toggleSessionConfig = not m.top.toggleSessionConfig
    else
        m.top.toggleSessionInfo = not m.top.toggleSessionInfo
    end if
    commandButton.uri = updateButtonURI(commandButton.id, m.selectedIndex)
end function

function goToLive() as void
    if not m.Islive
        return
    end if

    stopTimer()
    setSelectedIndex(Commands().resume)
    m.top.seek = m.top.duration
end function

function handleLeft() as void
    if m.selectedIndex < 1
        return
    end if
    oldSelectedIndex = m.selectedIndex
    m.selectedIndex = m.selectedIndex - 1
    redrawButtons(oldSelectedIndex)
end function

function handleRight() as void
    if m.selectedIndex >= (m.commandButtons.getChildCount() - 1)
        return
    end if
    nextButton = m.commandButtons.getChild(m.selectedIndex + 1)
    if nextButton.id = "play" and not nextButton.visible
        return
    end if
    oldSelectedIndex = m.selectedIndex
    m.selectedIndex = m.selectedIndex + 1
    redrawButtons(oldSelectedIndex)
end function

function setControl() as void
    control = m.commandButtons.getChild(m.selectedIndex).id
    if control = Commands().resume and LCase(m.top.state) = "playing"
        control = Commands().pause
    end if
    m.top.control = control
end function

function onCurrentPlayStateChanged(_) as void
    resume = m.top.findNode("resume")
    if LCase(m.top.state) = "playing"
        resume.uri = updateButtonURI(Commands().pause, 1)
        m.top.findNode("play").visible = false
        m.top.findNode("play").uri = updateButtonURI(Commands().play, -1)
        m.currentSeekMultiplierDirection = 0
        m.seekSizeOffset = 1
        m.top.findNode("fastforward").uri = updateButtonURI(Commands().fastforward, -1)
        m.top.findNode("rewind").uri = updateButtonURI(Commands().rewind, -1)
    else if LCase(m.top.state) = "paused"
        resume.uri = updateButtonURI(Commands().resume, 1)
        m.top.findNode("play").visible = m.Islive
    else if LCase(m.top.state) = "fastforward"
        m.currentSeekMultiplierDirection = 1
        m.seekSizeOffset = 10
    else if LCase(m.top.state) = "rewind"
        m.currentSeekMultiplierDirection = -1
        m.seekSizeOffset = 10
    end if
end function

function onCurrentPositionChanged(_) as void
    m.top.currentSeek = m.top.position
    m.isSeeking = false
end function

function onCurrentControlChanged(event) as void
    data = event.getData()
    if LCase(data) = Commands().pause
        m.top.state = "paused"
    else if LCase(data) = Commands().resume
        m.top.state = "playing"
    else if LCase(data) = Commands().fastforward
        m.top.state = "fastforward"
    else if LCase(data) = Commands().rewind
        m.top.state = "rewind"
    end if
end function

function onCurrentSeekChanged(_) as void
end function

function onTimerTick(_) as void
    if m.timerTick.control = "stop" or m.top.isSeeking = false
        stopTimer()
    end if
    nextSeek = m.top.currentSeek + (m.currentSeekMultiplierDirection * m.seekSizeOffset)
    if nextSeek >= 0
        m.top.currentSeek = nextSeek
    else
        m.top.currentSeek = 0
    end if
end function
