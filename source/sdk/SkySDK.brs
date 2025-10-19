function SkySDKWait(timeout as integer) as dynamic
    return skySDK()._wait(timeout)
end function

function skySDK() as object

    globalAA = getGLobalAA()
    if globalAA.SkySDKInstance <> invalid then return globalAA.SkySDKInstance

    SkySDKInstance = {
        port: invalid
        messageObservable: SkySDK_Utils_Observable()
        initialisePromise: invalid
        logger: invalid

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        getPlayerController: function() as object
            return SkySDK_Player_PlayerController()
        end function

        onMessage: function(callBack as string, callbackOwner as object) as void
            m.messageObservable.registerObserver(callBack, callbackOwner)
        end function

        removeEventListeners: function(callBackOwner as object) as void
            m.messageObservable.unRegisterObservers(callBackOwner)
        end function

        setMessagePort: function(port as object) as void
            m.port = port
        end function

        initLogger: function(params = {} as object) as void
            m.logger = newLogger(params)
        end function

        '|----------------------------------------------|
        '|       Private Methods                        |
        '|----------------------------------------------|

        _processMessage: function(msg as dynamic) as void
            if msg = invalid
                m.logger.error(SkySDK_UtilsStringUtils().substitute("{0} message = {1}", "SkySDK._processMessage", SkySDK_UtilsStringUtils().toString(msg)))
                return
            end if
            _event = { field: msg.getField(), data: msg.getData() }
            m.messageObservable.notifyObservers(_event)
        end function

        _wait: function(timeout as integer) as object
            if timeout < 0 then timeout = 0
            while true
                waitMessage = wait(timeout, m.port)
                m._processMessage(waitMessage)
                return waitMessage
            end while
            return invalid
        end function
    }

    globalAA.SkySDKInstance = SkySDKInstance
    return SkySDKInstance
end function
