function ListPage() as object
    this = {
        view: invalid
        type: "ListPage"

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        init: function() as void
            m.view = CreateObject("roSGNode", "ListPageView")
            m.view.observeField("selectedAsset", getGlobalAA().port)
        end function

        load: function(_ = invalid as object) as void
            m.view.items = Assets()
        end function

        destroy: function() as void
            m.view.unObserveField("selectedAsset")
            m.view = invalid
        end function

    }
    this.init()
    return this
end function
