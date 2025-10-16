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
            manifest: "testUrl",
            transport: "testTransport"
        },
        metadata: {
            assetTitle: "Test Asset",
            text: "Test Asset",
            categories: ["NoDRM"]
        }
    }

    _mockController = {}

    m.ExpectOnce(test.SUT, "_getPlayerController", invalid, _mockController)
    m.ExpectOnce(_mockController, "onSessionCreated", ["_handleSessionCreated", m.anyAAmatcher])
    m.ExpectOnce(_mockController, "createSession", [_testData, m.anyNodeMatcher])


    test.SUT.load(_testData)

end sub
