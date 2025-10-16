function SkySDK_Player_PlayerEngineItem(sessionItem as Object, commonPlayer as Object) as Object
    this = {
        sessionItem: sessionItem
        commonPlayer: commonPlayer
        video: invalid

        OBSERVABLE_FIELDS: {
            State: "state"
        }

        stateObservable: SkySDK_Utils_Observable()

        '|----------------------------------------------|
        '|       Main Tread message                     |
        '|----------------------------------------------|

        processMessage: function(_event) as Void
            if _event <> invalid
                if _event.field = "state"
                    if LCase(_event.data) = "playing"
                        print "Playing: ", m.sessionItem.metadata.assetTitle
                    end if
                    m.stateObservable.notifyObservers(_event.data)
                end if
            end if
        end function

        onStateChanged: function(callBack, callbackOwner) as Void
            m.stateObservable.registerObserver(callBack, callbackOwner)
        end function

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        play: function() as Void
            m.video.control = "play"
        end function

        pause: function() as Void
            m.video.control = "pause"
        end function

        resume: function() as Void
            m.video.control = "resume"
        end function

        stop: function() as Void
            m.video.control = "stop"
        end function

        destroy: function() as Void
            m.stop()
            skySDK().removeEventListeners(m)
            m.video.unObserveFieldScoped(m.OBSERVABLE_FIELDS.State)
            m.stateObservable.unRegisterAllObserver()
            m.commonPlayer.removeChild(m.video)
            m.video = invalid
        end function

        '|----------------------------------------------|
        '|              Private Methods                 |
        '|----------------------------------------------|

        _createVideoElement: function() as Object
            video = createObject("RoSGNode", "Video")
            video.id = "video"
            video.content = m._createVideoContent()
            return video
        end function

        _createVideoContent: function() as Object
            videoContent = createObject("RoSGNode", "ContentNode")
            videoContent.url = m.sessionItem.asset.manifest
            videoContent.streamFormat = "Hls"
            return videoContent
        end function

        '|----------------------------------------------|
        '|              Constructor                     |
        '|----------------------------------------------|

        _init: function() as Void
            m.video = m._createVideoElement()
            m.video.observeFieldScoped(m.OBSERVABLE_FIELDS.State, skySDK().port)
            m.commonPlayer.appendChild(m.video)
            m.play()
        end function
    }

    this._init()
    return this
end function
