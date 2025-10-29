'@TestSuite [PP] testStringUtils
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests testStringUtils
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

' file:///Users/jamesfolk/Downloads/core-video-sdk-roku_challenge-master/node_modules/rooibos/docs/module-BaseTestSuite.html#assertEqual

'@Setup
sub testStringUtils_setup()

    m.testString = "<TEST STRING>"
    m.testStringLong = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    m.testInteger = 0
    m.testLongInteger = 0&
    m.testFloat = 0.0!
    m.testDouble = 0.0#
    m.testBool = true

    m.testArray = [
        m.testString,
        m.testInteger,
        m.testLongInteger,
        m.testFloat,
        m.testDouble,
        m.testBool,
        { "obj": 1 }
    ]
    m.testObject = {
        "testString": m.testString,
        "testInteger": m.testInteger,
        "testLongInteger": m.testLongInteger,
        "testFloat": m.testFloat,
        "testDouble": m.testDouble,
        "testBool": m.testBool,
        "testArray": m.testArray,
        "testObject": { "obj": 1 }
    }
    m.testFunction = function()
        print "test function"
    end function
    m.testDatetime = CreateObject("roDateTime")
    m.testNode = CreateObject("roSGNode", "Task")
    m.testList = CreateObject("roList")
    m.stringUtils = SkySDK_UtilsStringUtils()
end sub

'@Test
sub testStringUtils_testtypes()
    m.assertTrue(SkySDK_UtilsTypeUtils().isString(m.testString))
    m.assertTrue(SkySDK_UtilsTypeUtils().isInteger(m.testInteger))
    m.assertTrue(SkySDK_UtilsTypeUtils().isLongInteger(m.testLongInteger))
    m.assertTrue(SkySDK_UtilsTypeUtils().isFloat(m.testFloat))
    m.assertTrue(SkySDK_UtilsTypeUtils().isDouble(m.testDouble))
    m.assertTrue(SkySDK_UtilsTypeUtils().isBoolean(m.testBool))
    m.assertTrue(SkySDK_UtilsTypeUtils().isArray(m.testArray))
    m.assertTrue(SkySDK_UtilsTypeUtils().isObject(m.testObject))
end sub

'@Test
sub testStringUtils_join()
    stringValue = SkySDK_UtilsStringUtils().join(m.testArray)
    expectedStringValue = "<TEST STRING>0000true{obj:1}"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().join(m.testArray, "-")
    expectedStringValue = "<TEST STRING>-0-0-0-0-true-{obj:1}"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().join(m.testString)
    expectedStringValue = ""
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().join(m.testInteger)
    expectedStringValue = ""
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().join(m.testLongInteger)
    expectedStringValue = ""
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().join(m.testFloat)
    expectedStringValue = ""
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().join(m.testDouble)
    expectedStringValue = ""
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().join(m.testBool)
    expectedStringValue = ""
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().join(m.testObject)
    expectedStringValue = ""
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_intToString()
    stringValue = SkySDK_UtilsStringUtils().intToString(m.testInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().intToString(m.testInteger, true)
    expectedStringValue = "00"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_longIntToString()
    stringValue = SkySDK_UtilsStringUtils().longIntToString(m.testLongInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().longIntToString(m.testLongInteger, true)
    expectedStringValue = "00"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_floatToString()
    stringValue = SkySDK_UtilsStringUtils().floatToString(m.testFloat)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_doubleToString()
    stringValue = SkySDK_UtilsStringUtils().doubleToString(m.testDouble)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_arrayToString()
    stringValue = SkySDK_UtilsStringUtils().arrayToString(m.testArray)
    expectedStringValue = "[<TEST STRING>,0,0,0,0,true,{obj:1}]"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().arrayToString(m.testString)
    expectedStringValue = "<TEST STRING>"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().arrayToString(m.testInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().arrayToString(m.testLongInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().arrayToString(m.testFloat)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().arrayToString(m.testDouble)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().arrayToString(m.testBool)
    expectedStringValue = "true"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().arrayToString(m.testObject)
    expectedStringValue = "{testObject:{obj:1},testBool:true,testArray:[<TEST STRING>,0,0,0,0,true,{obj:1}],testLongInteger:0,testFloat:0,testString:<TEST STRING>,testDouble:0,testInteger:0}"
    m.assertEqual(stringValue, expectedStringValue)

end sub

'@Test
sub testStringUtils_objectToString()
    stringValue = SkySDK_UtilsStringUtils().objectToString(m.testObject)
    expectedStringValue = "{testObject:{obj:1},testBool:true,testArray:[<TEST STRING>,0,0,0,0,true,{obj:1}],testLongInteger:0,testFloat:0,testString:<TEST STRING>,testDouble:0,testInteger:0}"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().objectToString(m.testString)
    expectedStringValue = "<TEST STRING>"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().objectToString(m.testInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().objectToString(m.testLongInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().objectToString(m.testFloat)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().objectToString(m.testDouble)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().objectToString(m.testBool)
    expectedStringValue = "true"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().objectToString(m.testArray)
    expectedStringValue = "[<TEST STRING>,0,0,0,0,true,{obj:1}]"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_toString()
    stringValue = SkySDK_UtilsStringUtils().toString(m.testString)
    expectedStringValue = "<TEST STRING>"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toString(m.testInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toString(m.testLongInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toString(m.testFloat)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toString(m.testDouble)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toString(m.testBool)
    expectedStringValue = "true"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toString(m.testArray)
    expectedStringValue = "[<TEST STRING>,0,0,0,0,true,{obj:1}]"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toString(m.testObject)
    expectedStringValue = "{testObject:{obj:1},testBool:true,testArray:[<TEST STRING>,0,0,0,0,true,{obj:1}],testLongInteger:0,testFloat:0,testString:<TEST STRING>,testDouble:0,testInteger:0}"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_substitute()
    stringValue = SkySDK_UtilsStringUtils().substitute("{0} {1} {2} {3}", m.testString, m.testInteger, m.testLongInteger, m.testFloat)
    expectedStringValue = "<TEST STRING> 0 0 0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().substitute("{0} {1} {2} {3}", m.testDouble, m.testBool, m.testArray, m.testObject)
    expectedStringValue = "0 true [<TEST STRING>,0,0,0,0,true,{obj:1}] {testObject:{obj:1},testBool:true,testArray:[<TEST STRING>,0,0,0,0,true,{obj:1}],testLongInteger:0,testFloat:0,testString:<TEST STRING>,testDouble:0,testInteger:0}"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_stringToBoolean()
    m.assertTrue(SkySDK_UtilsStringUtils().stringToBoolean("true"))
    m.assertFalse(SkySDK_UtilsStringUtils().stringToBoolean("false"))
    m.assertFalse(SkySDK_UtilsStringUtils().stringToBoolean(m.testString))
end sub

'@Test
sub testStringUtils_isEmpty()
    emptyString = ""
    max = Rnd(100)

    emptyCharacters = [
        SkySDK_UtilsStringUtils().NEW_LINE,
        SkySDK_UtilsStringUtils().TAB,
        SkySDK_UtilsStringUtils().SPACE
    ]

    for counter = 1 to max
        character = emptyCharacters[Rnd(emptyCharacters.count()) - 1]
        emptyString = emptyString + character
    end for

    m.assertFalse(SkySDK_UtilsStringUtils().isEmpty(m.testString))
    m.assertTrue(SkySDK_UtilsStringUtils().isEmpty(emptyString))
end sub

'@Test
sub testStringUtils_toStr()
    stringValue = SkySDK_UtilsStringUtils().toStr(m.testString)
    expectedStringValue = "<TEST STRING>"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(m.testInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(m.testLongInteger)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(m.testFloat)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(m.testDouble)
    expectedStringValue = "0"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(m.testBool)
    expectedStringValue = "true"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(m.testArray)
    expectedStringValue = "[<TEST STRING>,0,0,0,0,true,{obj:1}]"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(m.testObject)
    expectedStringValue = "{testObject:{obj:1},testBool:true,testArray:[<TEST STRING>,0,0,0,0,true,{obj:1}],testLongInteger:0,testFloat:0,testString:<TEST STRING>,testDouble:0,testInteger:0}"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(invalid)
    expectedStringValue = "Invalid"
    m.assertEqual(stringValue, expectedStringValue)

    stringValue = SkySDK_UtilsStringUtils().toStr(uninitilized)
    expectedStringValue = "Uninitilized"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_equals()
    m.assertTrue(SkySDK_UtilsStringUtils().equals(m.testString, "<TEST STRING>"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(m.testInteger, "0"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(m.testLongInteger, "0"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(m.testFloat, "0"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(m.testDouble, "0"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(m.testBool, "true"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(m.testArray, "[<TEST STRING>,0,0,0,0,true,{obj:1}]"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(m.testObject, "{testObject:{obj:1},testBool:true,testArray:[<TEST STRING>,0,0,0,0,true,{obj:1}],testLongInteger:0,testFloat:0,testString:<TEST STRING>,testDouble:0,testInteger:0}"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(invalid, "Invalid"))
    m.assertTrue(SkySDK_UtilsStringUtils().equals(uninitilized, "Uninitilized"))
end sub

'@Test
sub testStringUtils_split()
    arrayValue = SkySDK_UtilsStringUtils().split(m.testStringLong)
    expectedArrayValue = ["Lorem", "ipsum", "dolor", "sit", "amet,", "consectetur", "adipiscing", "elit,", "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore", "magna", "aliqua.", "Ut", "enim", "ad", "minim", "veniam,", "quis", "nostrud", "exercitation", "ullamco", "laboris", "nisi", "ut", "aliquip", "ex", "ea", "commodo", "consequat.", "Duis", "aute", "irure", "dolor", "in", "reprehenderit", "in", "voluptate", "velit", "esse", "cillum", "dolore", "eu", "fugiat", "nulla", "pariatur.", "Excepteur", "sint", "occaecat", "cupidatat", "non", "proident,", "sunt", "in", "culpa", "qui", "officia", "deserunt", "mollit", "anim", "id", "est", "laborum."]
    m.assertTrue(SkySDK_UtilsObjectUtils().equals(arrayValue, expectedArrayValue))

    arrayValue = SkySDK_UtilsStringUtils().split("")
    expectedArrayValue = []
    m.assertTrue(SkySDK_UtilsObjectUtils().equals(arrayValue, expectedArrayValue))

    newTestStringLong = SkySDK_UtilsStringUtils().replaceAll(m.testStringLong, SkySDK_UtilsStringUtils().SPACE, SkySDK_UtilsStringUtils().TAB)
    arrayValue = SkySDK_UtilsStringUtils().split(newTestStringLong, SkySDK_UtilsStringUtils().TAB)
    expectedArrayValue = ["Lorem", "ipsum", "dolor", "sit", "amet,", "consectetur", "adipiscing", "elit,", "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore", "magna", "aliqua.", "Ut", "enim", "ad", "minim", "veniam,", "quis", "nostrud", "exercitation", "ullamco", "laboris", "nisi", "ut", "aliquip", "ex", "ea", "commodo", "consequat.", "Duis", "aute", "irure", "dolor", "in", "reprehenderit", "in", "voluptate", "velit", "esse", "cillum", "dolore", "eu", "fugiat", "nulla", "pariatur.", "Excepteur", "sint", "occaecat", "cupidatat", "non", "proident,", "sunt", "in", "culpa", "qui", "officia", "deserunt", "mollit", "anim", "id", "est", "laborum."]
    m.assertTrue(SkySDK_UtilsObjectUtils().equals(arrayValue, expectedArrayValue))
end sub

'@Test
sub testStringUtils_replace()
    stringValue = SkySDK_UtilsStringUtils().replace(m.testString, "TEST", "MY TEST")
    expectedStringValue = "<MY TEST STRING>"
    m.assertEqual(stringValue, expectedStringValue)
end sub

'@Test
sub testStringUtils_replaceAll()
    stringValue = SkySDK_UtilsStringUtils().replaceAll(m.testStringLong, SkySDK_UtilsStringUtils().SPACE, "`")
    expectedStringValue = "Lorem`ipsum`dolor`sit`amet,`consectetur`adipiscing`elit,`sed`do`eiusmod`tempor`incididunt`ut`labore`et`dolore`magna`aliqua.`Ut`enim`ad`minim`veniam,`quis`nostrud`exercitation`ullamco`laboris`nisi`ut`aliquip`ex`ea`commodo`consequat.`Duis`aute`irure`dolor`in`reprehenderit`in`voluptate`velit`esse`cillum`dolore`eu`fugiat`nulla`pariatur.`Excepteur`sint`occaecat`cupidatat`non`proident,`sunt`in`culpa`qui`officia`deserunt`mollit`anim`id`est`laborum."
    m.assertEqual(stringValue, expectedStringValue)
end sub




