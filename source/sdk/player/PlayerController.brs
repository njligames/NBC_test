function SkySDK_Player_PlayerController() as Object
    this = {
        currentSession: invalid
        sessionCreatedObservable: SkySDK_Utils_Observable()

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        createSession: function(sessionItem, commonPlayer) as Void
            m.currentSession = SkySDK_Session_SessionController(sessionItem)
            m.sessionCreatedObservable.notifyObservers(m.currentSession)
            m.currentSession.start(commonPlayer)
        end function

        onSessionCreated: function(callback as String, callbackOwner as Object) as Void
            m.sessionCreatedObservable.registerObserver(callback, callbackOwner)
        end function

        destroy: function() as Void
            m.sessionCreatedObservable.unRegisterAllObserver()
            m.currentSession.destroy()
            m.currentSession = invalid
        end function
    }
    return this
end function
