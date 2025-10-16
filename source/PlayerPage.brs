function PlayerPage() as Object
    this = {
        view: invalid
        session: invalid
        playerController: invalid
        type: "PlayerPage"

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        load: function(data = invalid as Object) as Void
            m.view = CreateObject("roSGNode", "PlayerPageView")
            m._registerPlayerPageObservers()
            commonPlayer = m.view.findNode("commonPlayer")
            controls = m.view.findNode("buttonsBar")
            skySDK().onMessage("processMessage", m)
            controls.ObserveFieldScoped("control", skySDK().port)
            m.playerController = m._getPlayerController()
            m.playerController.onSessionCreated("_handleSessionCreated", m)
            m.playerController.createSession(data, commonPlayer)
        end function

        destroy: function() as Void
            m.playerController.destroy()
            m.playerController = invalid
            m.view = invalid
        end function

        _registerSessionObservables: function()
            m.session.onStateChanged("_handleStateChanged", m)
        end function

        _registerPlayerPageObservers: function()
            m.view.ObserveField("setControl", skySDK().port)
        end function

        _unregisterPlayerPageObservers: function()
            m.view.unObserveField("setControl")
        end function

        processMessage: function(_event)
            if _event <> invalid
                if _event.field = "control"

                end if
            end if
        end function

        _getPlayerController: function() as object
            return skySDK().getPlayerController()
        end function

        '|----------------------------------------------|
        '|                 Callbacks                    |
        '|----------------------------------------------|

        _handleSessionCreated: function(session as Object) as Void
            m.session = session
            m._registerSessionObservables()
        end function

        _handleStateChanged: function(state as String) as Void
            msg = {
                data: state
                field: "state"
            }
            m.view.callFunc("processMessage", { payload: msg })
        end function
    }
    return this
end function
