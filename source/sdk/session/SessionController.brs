function SkySDK_Session_SessionController(sessionItem as Object) as Object
    this = {
        sessionItem: sessionItem
        currentPlayerItem: invalid

        stateObservable: SkySDK_Utils_Observable()

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        start: function(commonPlayer as Object) as Void
            m._setState("Loading")
            m.currentPlayerItem = SkySDK_Player_PlayerEngineItem(m.sessionItem, commonPlayer)
            skySDK().onMessage("processMessage", m)
            m.currentPlayerItem.onStateChanged("_handlePlayerStateChange", m)
        end function

        processMessage: function(msg) as void
            m.currentPlayerItem.processMessage(msg)
        end function

        play: function() as Void
            m.currentPlayerItem.play()
        end function

        pause: function() as Void
            m.currentPlayerItem.pause()
        end function

        resume: function() as Void
            m.currentPlayerItem.resume()
        end function

        destroy: function() as Void
            skySDK().removeEventListeners(m)
            m.stateObservable.unRegisterAllObserver()
            m.currentPlayerItem.destroy()
        end function

        '|----------------------------------------------|
        '|       Register Observers Methods             |
        '|----------------------------------------------|

        onStateChanged: function(callback as String, callbackOwner as Object) as Void
            m.stateObservable.registerObserver(callback, callbackOwner)
        end function

        '|----------------------------------------------|
        '|              Private Methods                 |
        '|----------------------------------------------|

        _setState: function(state as String) as Void
            m.stateObservable.notifyObservers(state)
        end function

        _handlePlayerStateChange: function(state as String) as Void
            m.stateObservable.notifyObservers(state)
        end function
    }
    return this
end function
