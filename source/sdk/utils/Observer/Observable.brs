function SkySDK_Utils_Observable() as Object
    return {

        observers: []
        arrayUtils: SkySDK_Utils_ArrayUtils()
        locked: false

        registerObserver: function(callBack as Object, callBackOwner as Object) as Void
            if m.locked = false
                m._genObserverId(callBackOwner)
                m.observers.Push(SkySDK_Utils_Observer(callBack, callBackOwner))
            end if
        end function

        unRegisterObservers: function(callBackOwner as Object) as Void
            temp = []
            while m.observers.Count() > 0
                observerInstance = m.observers.Shift()
                if observerInstance.callBackOwner.observerId <> callBackOwner.observerId
                    temp.Push(observerInstance)
                end if
            end while
            m.observers = temp
        end function

        unRegisterAllObserver: function() as Void
            m.observers.Clear()
        end function

        lockObservable: function() as Void
            m.locked = true
        end function

        unlockObservable: function() as Void
            m.locked = false
        end function

        notifyObservers: function(payload = invalid as Dynamic) as Void
            observersCopy = m.arrayUtils.copy(m.observers)
            for each observerInstance in observersCopy
                ' Only update observerInstance if it still exists in the original array.
                if m.arrayUtils.find(observerInstance, m.observers, m._isSameObserver) <> invalid
                    observerInstance.update(payload)
                end if
            end for
        end function

        _isSameObserver: function(oA as Object, oB as Object) as Boolean
            return oA.callback = oB.callback AND oA.callbackOwner.observerId = oB.callbackOwner.observerId
        end function

        _genObserverId: function(callBackOwner as Object) as Void
            if callBackOwner <> invalid AND callBackOwner.observerId = invalid
                globalAA = getGLobalAA()
                id = globalAA.observerInstanceID
                if id = invalid
                    id = 0
                end if
                id++
                globalAA.observerInstanceID = id
                callBackOwner.observerId = id.toStr()
            end if
        end function

    }
end function
