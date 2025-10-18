function SkySDK_Player_PlayerEngineItem(sessionItem as object, commonPlayer as object) as object
    this = {
        sessionItem: sessionItem
        commonPlayer: commonPlayer
        video: invalid

        OBSERVABLE_FIELDS: {
            State: "state"
        }

        stateObservable: SkySDK_Utils_Observable()
        seekObservable: SkySDK_Utils_Observable()

        '|----------------------------------------------|
        '|       Main Tread message                     |
        '|----------------------------------------------|

        processMessage: function(_event) as void
            if _event <> invalid
                print "PlayerEngineItem.processMessage", _event.field, _event.data
                if _event.field = "state"
                    if LCase(_event.data) = "buffering"
                        print "Buffering: ", m.sessionItem.metadata.assetTitle
                    end if
                    if LCase(_event.data) = "playing"
                        print "Playing: ", m.sessionItem.metadata.assetTitle
                    end if
                    m.stateObservable.notifyObservers(_event.data)
                end if

                if _event.field = "seek"
                    m.seekObservable.notifyObservers(_event.data)
                end if

                if _event.field = "control"
                    if LCase(_event.data) = "pause"
                        print "Pause: ", m.sessionItem.metadata.assetTitle
                    end if
                    if LCase(_event.data) = "resume"
                        print "Resume: ", m.sessionItem.metadata.assetTitle
                    end if
                    if LCase(_event.data) = "fastforward"
                        print "Fast Forward: ", m.sessionItem.metadata.assetTitle
                    end if
                    if LCase(_event.data) = "rewind"
                        print "Rewind: ", m.sessionItem.metadata.assetTitle
                    end if
                end if
            end if
        end function

        onStateChanged: function(callBack, callbackOwner) as void
            m.stateObservable.registerObserver(callBack, callbackOwner)
        end function

        onSeekChanged: function(callBack, callbackOwner) as void
            m.seekObservable.registerObserver(callBack, callbackOwner)
        end function

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        play: function() as void
            m.video.control = "play"
        end function

        pause: function() as void
            m.video.control = "pause"
        end function

        resume: function() as void
            m.video.control = "resume"
        end function

        stop: function() as void
            m.video.control = "stop"
        end function

        seek: function(seconds as integer) as void
            if seconds >= 0
                if seconds > m.video.duration
                    seconds = m.video.duration
                end if
                m.video.seek = seconds
            end if
        end function

        destroy: function() as void
            m.stop()
            skySDK().removeEventListeners(m)
            m.video.unObserveFieldScoped(m.OBSERVABLE_FIELDS.State)
            m.stateObservable.unRegisterAllObserver()
            m.seekObservable.unRegisterAllObserver()
            m.commonPlayer.removeChild(m.video)
            m.video = invalid
        end function

        '|----------------------------------------------|
        '|              Private Methods                 |
        '|----------------------------------------------|

        _createVideoElement: function() as object
            video = createObject("RoSGNode", "Video")
            video.id = "video"
            video.content = m._createVideoContent()
            return video
        end function

        _createVideoContent: function() as object
            videoContent = createObject("RoSGNode", "ContentNode")
            videoContent.url = m.sessionItem.asset.manifest
            videoContent.streamFormat = "Hls"
            return videoContent
        end function

        '|----------------------------------------------|
        '|              Constructor                     |
        '|----------------------------------------------|

        _init: function() as void
            m.video = m._createVideoElement()
            m.video.observeFieldScoped(m.OBSERVABLE_FIELDS.State, skySDK().port)
            m.commonPlayer.appendChild(m.video)
            m.play()
        end function
    }

    this._init()
    return this
end function
