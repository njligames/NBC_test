'@TestSuite [PP] testPlayerPage
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests testPlayerPage
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test
sub testPlayerPage_load()

    test = {
        SUT: PlayerPage()
    }

    _testData = {
        asset: {
            manifest: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8",
            transport: "Hls"
        },
        metadata: {
            assetTitle: "Apple Stream",
            text: "Apple Stream",
            categories: ["NoDRM"]
        }
    }

    _mockController = {}

    m.ExpectOnce(test.SUT, "_getPlayerController", invalid, _mockController)
    m.ExpectOnce(_mockController, "onSessionCreated", ["_handleSessionCreated", m.anyAAmatcher])
    m.ExpectOnce(_mockController, "createSession", [_testData, m.anyNodeMatcher])


    test.SUT.load(_testData)

end sub
