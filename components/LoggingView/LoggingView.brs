function Init() as void
    bg = m.top.findNode("bg")
    m.scrollableText = m.top.findNode("scrollableText")
    m.scrollableText.width = bg.width
    m.scrollableText.height = bg.height
    m.top.observeField("message", "onMessageChanged")
end function

function onMessageChanged(event) as void
    messageText = SkySDK_UtilsStringUtils().join([event.getData(), Chr(10), m.scrollableText.text])

    m.scrollableText.text = messageText
end function
