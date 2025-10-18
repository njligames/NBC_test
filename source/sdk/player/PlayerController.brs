function SkySDK_Player_PlayerController() as object
    this = {
        currentSession: invalid
        sessionCreatedObservable: SkySDK_Utils_Observable()

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        createSession: function(sessionItem, commonPlayer) as void
            m.currentSession = SkySDK_Session_SessionController(sessionItem)
            m.sessionCreatedObservable.notifyObservers(m.currentSession)
            m.currentSession.start(commonPlayer)
        end function

        onSessionCreated: function(callback as string, callbackOwner as object) as void
            m.sessionCreatedObservable.registerObserver(callback, callbackOwner)
        end function

        destroy: function() as void
            m.sessionCreatedObservable.unRegisterAllObserver()
            m.currentSession.destroy()
            m.currentSession = invalid
        end function
    }
    return this
end function
