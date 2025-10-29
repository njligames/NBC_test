'@TestSuite [PP] testObjectUtils
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests testObjectUtils
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

' file:///Users/jamesfolk/Downloads/core-video-sdk-roku_challenge-master/node_modules/rooibos/docs/module-BaseTestSuite.html#assertEqual

'@Setup
sub testObjectUtils_setup()

    m.testString = "<TEST STRING>"
    m.testStringLong = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    m.testInteger = 0
    m.testLongInteger = 0&
    m.testFloat = 0.0!
    m.testDouble = 0.0#
    m.testBool = true
    m.smallObject = { "obj": 1 }

    m.testArray = [
        m.testString,
        m.testInteger,
        m.testLongInteger,
        m.testFloat,
        m.testDouble,
        m.testBool,
        m.smallObject
    ]
    m.testObject = {
        "testString": m.testString,
        "testInteger": m.testInteger,
        "testLongInteger": m.testLongInteger,
        "testFloat": m.testFloat,
        "testDouble": m.testDouble,
        "testBool": m.testBool,
        "testArray": m.testArray,
        "testObject": m.smallObject
    }
    m.testFunction = function()
        print "test function"
    end function
    m.testDatetime = CreateObject("roDateTime")
    m.testNode = CreateObject("roSGNode", "Task")
    m.testList = CreateObject("roList")
    m.stringUtils = SkySDK_UtilsStringUtils()
    m.objectUtils = SkySDK_UtilsObjectUtils()
end sub

'@Test
sub testObjectUtils_testtypes()
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
sub testObjectUtils_equals()
    m.assertFalse(m.objectUtils.equals(invalid, invalid))
    m.assertTrue(m.objectUtils.equals([], []))
    m.assertTrue(m.objectUtils.equals({}, {}))
    m.assertFalse(m.objectUtils.equals(invalid, []))
    m.assertFalse(m.objectUtils.equals(invalid, {}))
    m.assertFalse(m.objectUtils.equals([], invalid))
    m.assertFalse(m.objectUtils.equals({}, invalid))
    m.assertTrue(m.objectUtils.equals(m.testArray, m.testArray))
    m.assertTrue(m.objectUtils.equals(m.testObject, m.testObject))
    m.assertTrue(m.objectUtils.equals(m.testString, m.testString))
    m.assertTrue(m.objectUtils.equals(m.testInteger, m.testInteger))
    m.assertTrue(m.objectUtils.equals(m.testLongInteger, m.testLongInteger))
    m.assertTrue(m.objectUtils.equals(m.testFloat, m.testFloat))
    m.assertTrue(m.objectUtils.equals(m.testDouble, m.testDouble))
    m.assertTrue(m.objectUtils.equals(m.testBool, m.testBool))
end sub

'@Test
sub testObjectUtils_isEmpty()
    m.assertTrue(m.objectUtils.isEmpty([]))
    m.assertTrue(m.objectUtils.isEmpty({}))
    m.assertFalse(m.objectUtils.isEmpty(m.testArray))
    m.assertFalse(m.objectUtils.isEmpty(m.testObject))
end sub

'@Test
sub testObjectUtils_contains()
    m.assertTrue(m.objectUtils.contains(m.testArray, m.testString))
    m.assertTrue(m.objectUtils.contains(m.testArray, m.testInteger))
    m.assertTrue(m.objectUtils.contains(m.testArray, m.testLongInteger))
    m.assertTrue(m.objectUtils.contains(m.testArray, m.testFloat))
    m.assertTrue(m.objectUtils.contains(m.testArray, m.testDouble))
    m.assertTrue(m.objectUtils.contains(m.testArray, m.testBool))
    stop
    m.assertTrue(m.objectUtils.contains(m.testArray, m.smallObject))
    m.assertTrue(m.objectUtils.contains(m.testArray, m.smallObject))

    anotherTestString = "<Another TEST STRING>"
    anotherTestInteger = 1
    anotherTestLongInteger = 1&
    anotherTestFloat = 0.1!
    anotherTestDouble = 0.1#
    anotherTestBool = false
    m.assertFalse(m.objectUtils.contains(m.testArray, anotherTestString))
    m.assertFalse(m.objectUtils.contains(m.testArray, anotherTestInteger))
    m.assertFalse(m.objectUtils.contains(m.testArray, anotherTestLongInteger))
    m.assertFalse(m.objectUtils.contains(m.testArray, anotherTestFloat))
    m.assertFalse(m.objectUtils.contains(m.testArray, anotherTestDouble))
    m.assertFalse(m.objectUtils.contains(m.testArray, anotherTestBool))

    m.assertFalse(m.objectUtils.contains([], anotherTestString))
    m.assertFalse(m.objectUtils.contains([], anotherTestInteger))
    m.assertFalse(m.objectUtils.contains([], anotherTestLongInteger))
    m.assertFalse(m.objectUtils.contains([], anotherTestFloat))
    m.assertFalse(m.objectUtils.contains([], anotherTestDouble))
    m.assertFalse(m.objectUtils.contains([], anotherTestBool))
end sub

'@Test
sub testObjectUtils_indexOf()
end sub

'@Test
sub testObjectUtils_add()
end sub

'@Test
sub testObjectUtils_replace()
end sub

'@Test
sub testObjectUtils_subArray()
end sub

'@Test
sub testObjectUtils_toString()
end sub

'@Test
sub testObjectUtils_filter()
end sub

'@Test
sub testObjectUtils_merge()
end sub
