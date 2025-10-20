function SkySDK_Session_SessionController(sessionItem as object) as object
    this = {
        sessionItem: sessionItem
        currentPlayerItem: invalid

        stateObservable: SkySDK_Utils_Observable()
        seekObservable: SkySDK_Utils_Observable()
        positionObservable: SkySDK_Utils_Observable()

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        start: function(commonPlayer as object) as void
            m._setState("Loading")
            m.currentPlayerItem = SkySDK_Player_PlayerEngineItem(m.sessionItem, commonPlayer)
            skySDK().onMessage("processMessage", m)
            m.currentPlayerItem.onStateChanged("_handlePlayerStateChange", m)
            m.currentPlayerItem.onSeekChanged("_handlePlayerSeekChange", m)
            m.currentPlayerItem.onPositionChanged("_handlePlayerPositionChange", m)
        end function

        processMessage: function(msg) as void
            m.currentPlayerItem.processMessage(msg)
        end function

        play: function() as void
            m.currentPlayerItem.play()
        end function

        pause: function() as void
            m.currentPlayerItem.pause()
        end function

        resume: function() as void
            m.currentPlayerItem.resume()
        end function

        seek: function(seconds as integer) as void
            m.currentPlayerItem.seek(seconds)
        end function

        destroy: function() as void
            skySDK().removeEventListeners(m)
            m.stateObservable.unRegisterAllObserver()
            m.seekObservable.unRegisterAllObserver()
            m.positionObservable.unRegisterAllObserver()
            m.currentPlayerItem.destroy()
        end function

        '|----------------------------------------------|
        '|       Register Observers Methods             |
        '|----------------------------------------------|

        onStateChanged: function(callback as string, callbackOwner as object) as void
            m.stateObservable.registerObserver(callback, callbackOwner)
        end function

        onSeekChanged: function(callback as string, callbackOwner as object) as void
            m.seekObservable.registerObserver(callback, callbackOwner)
        end function

        onPositionChanged: function(callback as string, callbackOwner as object) as void
            m.positionObservable.registerObserver(callback, callbackOwner)
        end function

        '|----------------------------------------------|
        '|              Private Methods                 |
        '|----------------------------------------------|

        _setState: function(state as string) as void
            m.stateObservable.notifyObservers(state)
        end function

        _setSeek: function(seconds as integer) as void
            m.seekObservable.notifyObservers(seconds)
        end function

        _handlePlayerStateChange: function(state as string) as void
            m.stateObservable.notifyObservers(state)
        end function

        _handlePlayerSeekChange: function(seconds as integer) as void
            m.seekObservable.notifyObservers(seconds)
        end function

        _handlePlayerPositionChange: function(seconds as integer) as void
            m.positionObservable.notifyObservers(seconds)
        end function

    }
    return this
end function
