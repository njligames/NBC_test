'@TestSuite [PP] testStringUtils
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests testStringUtils
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

' file:///Users/jamesfolk/Downloads/core-video-sdk-roku_challenge-master/node_modules/rooibos/docs/module-BaseTestSuite.html#assertEqual

'@Setup
sub testStringUtils_setup()

    m.testString = "<TEST STRING>"
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