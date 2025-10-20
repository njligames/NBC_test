sub Main()

    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")

    m.currentPage = invalid

    screen.setMessagePort(m.port)

    skySDK().setMessagePort(m.port)
    params = readConfigFile("pkg:/source/config/config.json")
    skySDK().initLogger(createLoggerOptionsFromParams(params))
    m.logger = skySDK().logger
    print "SDK initialized with success..."

    m.scene = screen.CreateScene("MainScene")
    screen.show()
    _addNewPage(ListPage())
    m.scene.observeField("backPressed", m.port)

    while true
        msg = SkySDKWait(0)
        if msg <> invalid
            msgType = type(msg)
            if msgType = "roSGScreenEvent"
                if msg.isScreenClosed() then return
            else if msgType = "roSGNodeEvent"
                data = msg.getData()
                field = msg.getField()
                if m.currentPage.type = "ListPage"
                    if field = "selectedAsset"
                        _removeOldPage()
                        _addNewPage(PlayerPage(), data)
                    else if field = "backPressed"
                        return
                    end if
                else if m.currentPage.type = "PlayerPage"
                    if field = "backPressed"
                        _removeOldPage()
                        _addNewPage(ListPage())
                    end if
                end if
            end if
        end if
    end while
end sub

'|----------------------------------------------|
'|              Private Methods                 |
'|----------------------------------------------|

function _removeOldPage()
    m.scene.removeChild(m.currentPage.view)
    m.currentPage.destroy()
end function

function _addNewPage(newPage, data = invalid as object)
    m.currentPage = newPage
    m.currentPage.load(data)
    m.scene.appendChild(m.currentPage.view)
    m.currentPage.view.setFocus(true)
end function
