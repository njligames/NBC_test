function ListPage() as Object
    this = {
        view: invalid
        type: "ListPage"

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        init: function() as Void
            m.view = CreateObject("roSGNode", "ListPageView")
            m.view.observeField("selectedAsset", getGlobalAA().port)
        end function

        load: function(data = invalid as Object) as Void
            m.view.items = Assets()
        end function

        destroy: function() as Void
            m.view.unObserveField("selectedAsset")
            m.view = invalid
        end function

    }
    this.init()
    return this
end function
