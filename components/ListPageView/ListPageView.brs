function Init() as void
    m.selectedLabel = m.top.findNode("selectedLabel")
    m.selectedLabelCategory = m.top.findNode("selectedLabelCategory")
    m.selectedText = m.top.findNode("selectedText")
    m.assetImage = m.top.findNode("assetImage")
    m.rowList = m.top.findNode("rowList")
    _initRowList()
    m.rowList.ObserveField("rowItemFocused", "onRowItemFocused")
    m.rowList.observeField("itemSelected", "handleButtonClick")
    m.top.observeField("focusedChild", "onCurrentFocusedChildChanged")
    m.top.observeField("items", "onItemsChanged")
    m.focused = false

    m.categories = []
    m.itemList = {}
end function

function _initRowList()
    m.rowList.itemComponentName = "RowListItem"
    m.rowList.numRows = 3
    m.rowList.itemSize = [1200, 90]
    m.rowList.rowHeights = [90]
    m.rowList.rowItemSize = [120, 90]
    m.rowList.itemSpacing = [0, 70]
    m.rowList.rowItemSpacing = [10, 0]
    m.rowList.rowLabelOffset = [0, 20]
    m.rowList.rowFocusAnimationStyle = "fixedFocusWrap"
    m.rowList.vertFocusAnimationStyle = "fixedFocusWrap"
    m.rowList.showRowLabel = true
    m.rowList.rowLabelColor = "0xa0b033ff"
    m.rowList.visible = true
    m.rowList.SetFocus(true)
end function

function onItemsChanged() as void
    _buildItemList()
    m.rowList.content = _getRowListContent()
end function

function _buildItemList() as void
    for i = 0 to m.top.items.Count() - 1
        item = m.top.items[i]
        for j = 0 to item.metadata.categories.Count() - 1
            cat = item.metadata.categories[j]
            if m.itemList[cat] = invalid
                m.itemList[cat] = []
                m.categories.Push(cat)
            end if
            m.itemList[cat].Push(item)
        end for
    end for
end function

function _getRowListContent() as object
    data = CreateObject("roSGNode", "ContentNode")
    for i = 0 to m.categories.Count() - 1
        _createRowAssets(data, m.categories[i])
    end for
    return data
end function

function _createRowAssets(data, category) as void
    row = data.CreateChild("ContentNode")
    row.title = category
    for each _ in m.itemList[category]
        row.CreateChild("RowListItemData")
    end for
end function

function onRowItemFocused() as void
    row = m.rowList.rowItemFocused[0]
    col = m.rowList.rowItemFocused[1]

    selectedName = ""
    item = _findAsset(row, col)
    selectedName = item.asset.key
    selectedText = ""
    if item.metadata <> invalid
        if item.metadata.assetTitle <> invalid and item.metadata.assetTitle <> ""
            selectedName = item.metadata.assetTitle
        end if
        selectedText = item.metadata.text
    end if

    m.selectedText.text = selectedText
    if selectedName <> invalid then m.selectedLabel.text = selectedName else m.selectedLabel.text = "N/A"
    m.selectedLabelCategory.text = m.categories[row]
end function

function handleButtonClick(_) as void
    row = m.rowList.rowItemSelected[0]
    col = m.rowList.rowItemSelected[1]

    item = _findAsset(row, col)
    m.top.selectedAsset = item
end function

function _findAsset(row, col) as object
    for i = 0 to m.itemList[m.categories[row]].Count() - 1
        if col = i
            return m.itemList[m.categories[row]][i]
        end if
    end for
    return invalid
end function

function onCurrentFocusedChildChanged(_) as void
    if m.focused = false and m.top.hasFocus()
        m.rowList.setFocus(true)
        m.focused = true
    else if m.focused = true and not m.top.hasFocus() and not m.top.isInFocusChain()
        m.focused = false
    end if
end function
