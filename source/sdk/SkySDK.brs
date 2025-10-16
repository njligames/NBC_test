function SkySDKWait(timeout as Integer) as Dynamic
    return skySDK()._wait(timeout)
end function

function skySDK() as Object

    globalAA = getGLobalAA()
    if globalAA.SkySDKInstance <> invalid then return globalAA.SkySDKInstance

    SkySDKInstance = {
        port: invalid
        messageObservable: SkySDK_Utils_Observable()
        initialisePromise: invalid

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        getPlayerController: function() as Object
            return SkySDK_Player_PlayerController()
        end function

        onMessage: function(callBack as String, callbackOwner as Object) as Void
            m.messageObservable.registerObserver(callBack, callbackOwner)
        end function

        removeEventListeners: function(callBackOwner as Object) as Void
            m.messageObservable.unRegisterObservers(callBackOwner)
        end function

        setMessagePort: function(port as Object) as Void
            m.port = port
        end function

        '|----------------------------------------------|
        '|       Private Methods                        |
        '|----------------------------------------------|

        _processMessage: function(msg as Dynamic) as Void
            if msg = invalid then return
            _event = {field: msg.getField(), data: msg.getData()}
            m.messageObservable.notifyObservers(_event)
        end function

        _wait: function(timeout as Integer) as Object
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
