function SkySDK_Utils_Observer(callback as Dynamic, callbackOwner as Object) as Object
    return {
        callback: callback
        callbackOwner: callbackOwner

        executeCallBack: function(args = []) as Void
            if m.callbackOwner <> invalid AND m.callbackOwner.DoesExist(m.callback)
                if args <> invalid AND args.Count() > 0
                    m.callbackOwner[m.callback](args[0])
                else
                    m.callbackOwner[m.callback]()
                end if
            end if
        end function

        update: function(payload as Dynamic) as Void
            m.executeCallBack([payload])
        end function
    }
end function
