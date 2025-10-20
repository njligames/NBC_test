function SkySDK_Utils_Utils() as object
    return {
        callFunc: function(Func as dynamic, args = [] as object) as dynamic
            if GetInterface(Func, "ifFunction") <> invalid
                if args = invalid or args.Count() = 0 then return Func()
                if args.Count() = 1 then return Func(args[0])
                if args.Count() = 2 then return Func(args[0], args[1])
                if args.Count() = 3 then return Func(args[0], args[1], args[2])
                if args.Count() = 4 then return Func(args[0], args[1], args[2], args[3])
                if args.Count() = 5 then return Func(args[0], args[1], args[2], args[3], args[4])
                if args.Count() > 5 then return Func(args[0], args[1], args[2], args[3], args[4], args[5])
            end if
            return invalid
        end function

        callScopedFunc: function(Func as dynamic, args = [] as object, destination = object as dynamic) as dynamic
            if GetInterface(Func, "ifString") <> invalid and GetInterface(destination, "ifAssociativeArray") <> invalid and destination.DoesExist(Func)
                if args = invalid or args.Count() = 0 then return destination[Func]()
                if args.Count() = 1 then return destination[Func](args[0])
                if args.Count() = 2 then return destination[Func](args[0], args[1])
                if args.Count() = 3 then return destination[Func](args[0], args[1], args[2])
                if args.Count() = 4 then return destination[Func](args[0], args[1], args[2], args[3])
                if args.Count() = 5 then return destination[Func](args[0], args[1], args[2], args[3], args[4])
                if args.Count() > 5 then return destination[Func](args[0], args[1], args[2], args[3], args[4], args[5])
            end if
            return invalid
        end function
    }
end function

function SkySDK_Utils_ArrayUtils() as object
    return {

        ' Searches for an element that matches the conditions defined by the equality comparer, and returns the first occurrence.
        ' @param context { Dynamic }, context available in EqualityComparerFunc scope
        ' @param array { roArray }, array with the elements to search
        ' @params EqualityComparerFunc { Function(context as Dynamic, el as Dynamic) }, compares values and determines if they are equal
        ' @return { Dynamic }, returns the first element that satisfy the equality comparer condition
        find: function(context as dynamic, array as dynamic, EqualityComparerFunc as dynamic) as dynamic
            if GetInterface(array, "ifArray") <> invalid
                for i = 0 to array.Count() - 1
                    if m._execFunc(EqualityComparerFunc, context, [array[i]]) = true
                        return array[i]
                    end if
                end for
            end if
            return invalid
        end function

        ' Checks if an array contains a given value
        ' @param element { Dynamic }, element to find
        ' @param array { Object }, array to search in
        ' @return { Boolean }, True if element is present, false otherwise
        contains: function(element as dynamic, array as object) as boolean
            doesExist = SkySDK_Utils_ArrayUtils().find(element, array, function(elementA, elementB)
                return elementA <> invalid and elementB <> invalid and elementA = elementB
            end function)
            return doesExist <> invalid
        end function

        ' Performs the specified action defined by Func on each element of the specified array
        ' @param context { Dynamic }, context available in Func scope
        ' @param array { roArray }, array with the elements
        ' @params Func { Function(context as Dynamic, el as Dynamic) }, The Action to perform on each element of array
        forEach: function(context as dynamic, array as dynamic, Func as dynamic) as void
            if GetInterface(array, "ifArray") <> invalid
                for i = 0 to array.Count() - 1
                    m._execFunc(Func, context, [array[i]])
                end for
            end if
        end function

        ' Projects each element of a sequence into a new form defined by the TransformFunc
        ' @param context { Dynamic }, context available in EqualityComparerFunc scope
        ' @param array { roArray }, A sequence of values to invoke a transform function on
        ' @params TransformFunc { Function(context as Dynamic, el as Dynamic) }, A transform function to apply to each source element
        ' @return { roArray }, return an new array whose elements are the result of invoking the transform function on each element of the array
        select: function(context as dynamic, array as dynamic, TransformFunc as dynamic) as object
            result = []
            if GetInterface(array, "ifArray") <> invalid
                for i = 0 to array.Count() - 1
                    result.Push(m._execFunc(TransformFunc, context, [array[i]]))
                end for
            end if
            return result
        end function

        ' Filters a sequence of values defined by the equality comparer.
        ' @param context { Dynamic }, context available in EqualityComparerFunc scope
        ' @param array { roArray }, array to filter
        ' @params EqualityComparerFunc { Function(context as Dynamic, el as Dynamic) }, compares values and determines if they are equal
        ' @return { roArray }, returns a new array that contains elements from the input sequence that satisfy the condition.
        where: function(context as dynamic, array as dynamic, EqualityComparerFunc as dynamic) as object
            result = []
            if GetInterface(array, "ifArray") <> invalid
                for i = 0 to array.Count() - 1
                    if EqualityComparerFunc(context, array[i]) = true
                        result.Push(m._execFunc(EqualityComparerFunc, context, [array[i]]))
                    end if
                end for
            end if
            return result
        end function

        ' Returns distinct elements from a sequence by using the equality comparer to compare values.
        ' @param context { Dynamic }, context available in EqualityComparerFunc scope
        ' @param array { roArray }, array to intersect
        ' @params EqualityComparerFunc { Function(context as Dynamic, el1 as Dynamic, el2 as Dynamic) }, compares values and determines if they are equal
        ' @return { roArray }, return a new array with distinct elements based on EqualityComparerFunc equality comparison
        distinct: function(context as dynamic, array as dynamic, EqualityComparerFunc as dynamic) as object
            result = []
            if GetInterface(array, "ifArray") <> invalid
                for i = 0 to array.Count() - 1
                    if i = 0
                        result.Push(array[i])
                    else
                        match = false
                        for j = 0 to result.Count() - 1
                            match = m._execFunc(EqualityComparerFunc, context, [array[i], result[j]])
                            if match = true then exit for
                        end for
                        if not match then result.Push(array[i])
                    end if
                end for
            end if
            return result
        end function

        ' Intersect two arrays
        ' @param context { Dynamic }
        ' @param array1 { roArray }, first array sequence
        ' @param array2 { roArray }, second array sequence
        ' @params EqualityComparerFunc { Function(context as Dynamic, el1 as Dynamic, el2 as Dynamic) }, compares values and determines if they are equal
        ' @return { roArray }, A new array that contains the elements that form the set intersection of two sequences.
        intersect: function(context as dynamic, array1 as dynamic, array2 as dynamic, EqualityComparerFunc as dynamic) as object
            result = []
            if GetInterface(array1, "ifArray") <> invalid and GetInterface(array2, "ifArray") <> invalid
                for i = 0 to array1.Count() - 1
                    for j = 0 to array2.Count() - 1
                        match = m._execFunc(EqualityComparerFunc, context, [array1[i], array2[j]])
                        if match = true then result.Push(array1[i])
                    end for
                end for
            end if
            return result
        end function

        _execFunc: function(Func as dynamic, context as dynamic, args = [] as object) as dynamic
            if GetInterface(Func, "ifString") <> invalid and GetInterface(context, "ifAssociativeArray") <> invalid
                return SkySDK_Utils_Utils().callScopedFunc(Func, args, context)
            else
                funcArgs = [context]
                if args <> invalid then funcArgs.Append(args)
                return SkySDK_Utils_Utils().callFunc(Func, funcArgs)
            end if
        end function

        ' Return a clone of the original array
        ' @param originalArray { roArray }, the array to clone
        ' @return { roArray } the cloned copy of originalArray or empty array if originalArray is not an array
        copy: function(originalArray as dynamic) as object
            result = []
            if GetInterface(originalArray, "ifArray") <> invalid
                result = [] : result.append(originalArray)
            end if
            return result
        end function
    }
end function

function SkySDK_Utils_ObjectUtils() as object
    return {
        ' copies the values and properties from one or more source objects to a target object
        ' @param target { Dynamic }, target to copy the source properties to
        ' @param sources { Dynamic }, sources object/array of objects to copy the properties from
        ' @return { Dynamic }, returns target element merged with the source properties
        assign: function(target as object, sources = [] as dynamic) as dynamic
            if GetInterface(target, "ifAssociativeArray") <> invalid and sources <> invalid
                if GetInterface(sources, "ifArray") = invalid then sources = [sources]
                for i = 0 to sources.Count() - 1
                    if GetInterface(sources[i], "ifAssociativeArray") <> invalid
                        target.Append(sources[i])
                    end if
                end for
            end if
            return target
        end function

        ' Gets the value at path of object.
        ' @param obj { Dynamic }, the object to query
        ' @param path { String }, the path of the property to get
        ' @return { Dynamic }, returns the objects path value or Invalid if undefined. Returns Invalid if the path is not found
        getPath: function(obj as dynamic, path as string, defaultValue = invalid as dynamic) as dynamic
            if obj <> invalid and (GetInterface(obj, "ifAssociativeArray") <> invalid or GetInterface(obj, "ifArray") <> invalid)
                pathSplit = path.Split("/")
                property = pathSplit.Shift()

                if property <> invalid and property.trim() <> ""
                    if GetInterface(obj, "ifArray") <> invalid
                        r = CreateObject("roRegex", "\[(\d+)\]", "g")
                        arrayMatch = r.Match(property)
                        if arrayMatch <> invalid and arrayMatch.Count() = 2
                            if pathSplit.Count() = 0
                                if obj[arrayMatch[1].toInt()] <> invalid then return obj[arrayMatch[1].toInt()]
                                return defaultValue
                            end if
                            return m.getPath(obj[arrayMatch[1].toInt()], pathSplit.Join("/"), defaultValue)
                        end if
                        return invalid
                    else if GetInterface(obj, "ifAssociativeArray") <> invalid and obj.DoesExist(property)
                        if pathSplit.Count() = 0
                            if obj[property] <> invalid then return obj[property]
                            return defaultValue
                        end if
                        return m.getPath(obj[property], pathSplit.Join("/"), defaultValue)
                    end if
                    return defaultValue
                end if
            end if
            return defaultValue
        end function

        ' Checks if path is a direct property of object
        ' @param obj { Dynamic }, the object to query
        ' @param path { String }, the path of the property to get
        ' @return { Boolean }, returns true if path exists, else false.
        hasPath: function(obj as dynamic, path as string) as boolean
            return m.getPath(obj, path, invalid) <> invalid
        end function
    }
end function

function SkySDK_Utils_DisplayUtils() as object
    return {
        getDefaultPlayerDimensions: function() as dynamic
            deviceInfo = skySDK().getDeviceInfo()
            return { width: deviceInfo.uiResolution.width, height: deviceInfo.uiResolution.height, x: 0, y: 0 }
        end function
    }
end function

function SkySDK_Utils_URLUtils() as object
    return {
        parseURLQueryString: function(url as string) as object
            result = {}
            urlSplitted = url.Split("?")
            if urlSplitted.Count() < 2
                return result
            end if
            queryStringParams = urlSplitted[1].Split("&")
            for each queryStringParam in queryStringParams
                param = queryStringParam.Split("=")
                result[param[0]] = param[1]
            end for
            return result
        end function
    }
end function

function SkySDK_UtilsTypeUtils() as object
    return {
        isString: function(obj as dynamic) as boolean : return m.isType(obj, "ifString") : end function,
        isBool: function(obj as dynamic) as boolean : return m.isType(obj, "ifBoolean") : end function,
        isBoolean: function(obj as dynamic) as boolean : return m.isBool(obj) : end function,
        isInt: function(obj as dynamic) as boolean : return m.isType(obj, "ifInt") : end function,
        isInteger: function(obj as dynamic) as boolean : return m.isInt(obj) : end function,
        isLongInt: function(obj as dynamic) as boolean : return m.isType(obj, "ifLongInt") : end function,
        isLongInteger: function(obj as dynamic) as boolean : return m.isLongInt(obj) : end function,
        isArray: function(obj as dynamic) as boolean : return m.isType(obj, "ifArray") : end function,
        isList: function(obj as dynamic) as boolean : return m.isType(obj, "ifList") : end function,
        isFloat: function(obj as dynamic) as boolean : return m.isType(obj, "ifFloat") : end function,
        isDouble: function(obj as dynamic) as boolean : return m.isType(obj, "ifDouble") : end function,
        isDateTime: function(obj as dynamic) as boolean : return m.isType(obj, "ifDateTime") : end function,
        isObject: function(obj as dynamic) as boolean : return m.isType(obj, "ifAssociativeArray") : end function,
        isFunction: function(obj as dynamic) as boolean : return m.isType(obj, "ifFunction") : end function,
        isSgNodeSubtype: function(obj as dynamic, subType as dynamic) as boolean: return (m.isType(obj, "ifSGNodeDict") and m.isString(subType) and obj.isSubtype(subType)) : end function,

        isComparable: function(obj as dynamic) as boolean
            if obj = invalid then return true
            if m.isString(obj) then return true
            if m.isBool(obj) then return true
            if m.isInt(obj) then return true
            if m.isLongInt(obj) then return true
            if m.isFloat(obj) then return true
            if m.isDouble(obj) then return true
            return false
        end function,

        isNumber: function(obj as dynamic) as boolean
            if m.isInt(obj) then return true
            if m.isLongInt(obj) then return true
            if m.isFloat(obj) then return true
            if m.isDouble(obj) then return true
            return false
        end function,

        isType: function(obj as dynamic, ifType as string) as boolean
            if obj = invalid then return false
            if getInterface(obj, ifType) = invalid then return false
            return true
        end function,

        isUnitialized: function(val as dynamic) as boolean
            return type(val) = "<uninitialized>"
        end function
    }
end function

function SkySDK_UtilsStringUtils() as object
    return {
        ' Joins an array of different elements to a single string. Calls toString on each
        ' element of the array so object types will be printed by default: "Lorem Ipsum roRegex"
        ' @param arr the array to join
        ' @param delimeter the delimeter to append to each element
        ' @returns a String of all elements on the array
        join: function(arr as dynamic, delimeter = "" as string) as string
            if not SkySDK_UtilsTypeUtils().isArray(arr)
                return ""
            end if

            result = ""
            for i = 0 to arr.count() - 1 step + 1
                el = arr[i]
                if i = 0
                    result = m.toString(el)
                else
                    result = result + delimeter + m.toString(el)
                end if
            end for

            return result
        end function,

        ' Convert int to string. This is necessary because the builtin Stri(x) prepends whitespace
        ' @param {Integer} i - the integer to convert
        ' @param {Boolean} [prependZero = false] - Indicates to add 0 to values less than 10
        ' @returns {String} the string value of the integer
        intToString: function(i as integer, prependZero = false as boolean) as string
            s = Stri(i)
            s = s.trim()

            if prependZero and i >= 0 and i < 10
                s = "0" + s
            end if

            return s
        end function,

        ' Convert int to string. This is necessary because the builtin Stri(x) prepends whitespace
        ' @param {Integer} i - the integer to convert
        ' @param {Boolean} [prependZero = false] - Indicates to add 0 to values less than 10
        ' @returns {String} the string value of the integer
        longIntToString: function(i& as longinteger, prependZero = false as boolean) as string
            s = i&.toStr()
            s = s.trim()

            if prependZero and i& >= 0 and i& < 10
                s = "0" + s
            end if

            return s
        end function,

        ' Convert Float to string. This is necessary because the builtin Stri(x) prepends whitespace
        ' @param {Float} x - the Float to convert
        ' @returns {String} the string value of the Float
        floatToString: function(x! as float) as string
            s = Str(x!)
            return s.trim()
        end function,

        ' Convert double to string. This is necessary because the builtin Stri(x) prepends whitespace
        ' @param {Double} x - the Double to convert
        ' @returns {String} the string value of the Double
        doubleToString: function(x# as double) as string
            s = Str(x#)
            return s.trim()
        end function,

        arrayToString: function(arr as object) as string
            if not SkySDK_UtilsTypeUtils().isArray(arr) then
                return m.toString(arr)
            end if

            res = []
            for each el in arr
                ' Protects against invalid properties in the array being evaluated as <UNINITILIZED>
                ' This issue was introduced in firmware 9.0.0
                if type(el) = "<uninitialized>" then el = invalid

                if SkySDK_UtilsTypeUtils().isArray(el) then
                    res.push(m.arrayToString(el))
                else
                    res.push(m.toString(el))
                end if
            end for

            return "[" + m.join(res, ",") + "]"
        end function,

        objectToString: function(obj as object) as string
            if not SkySDK_UtilsTypeUtils().isObject(obj) then
                return m.toString(obj)
            end if

            res = []

            if SkySDK_UtilsTypeUtils().isType(obj, "ifEnum")
                for each k in obj
                    el = obj[k]

                    str = k + ":"
                    if SkySDK_UtilsTypeUtils().isObject(el) then
                        str = str + m.objectToString(el)
                    else if SkySDK_UtilsTypeUtils().isArray(el) then
                        str = str + m.arrayToString(el)
                    else
                        str = str + m.toString(el)
                    end if

                    res.push(str)
                end for
            else
                objType = type(obj)
                res.push("<ObjectNotIfEnum_cannotPrint>:" + objType)
            end if
            return "{" + m.join(res, ",") + "}"
        end function,

        ' Converts anything to a string, even an Invalid value.
        ' @param {Dynamic} the value to convert to a string.
        ' @returns {String} the converted string or the type if we can't convert
        toString: function(any as dynamic) as string
            if SkySDK_UtilsTypeUtils().isUnitialized(any) then return "Uninitilized"
            if any = invalid then return "Invalid"
            if SkySDK_UtilsTypeUtils().isString(any) then return any
            if SkySDK_UtilsTypeUtils().isInt(any) then return m.intToString(any)
            if SkySDK_UtilsTypeUtils().isLongInt(any) then return m.longIntToString(any)
            if SkySDK_UtilsTypeUtils().isBool(any)
                if any then return "true"
                return "false"
            end if
            if SkySDK_UtilsTypeUtils().isFloat(any) then return m.floatToString(any)
            if SkySDK_UtilsTypeUtils().isDouble(any) then return m.doubleToString(any)
            if SkySDK_UtilsTypeUtils().isArray(any) then return m.arrayToString(any)
            if SkySDK_UtilsTypeUtils().isObject(any) then return m.objectToString(any)
            return type(any)
        end function,

        ' Like the native substitute but accepts any value and not only strings
        ' @param {String} str - the string with the format.
        ' @param {Dynamic} a - the first value to substitute.
        ' @param {Dynamic} b - the second value to substitute.
        ' @param {Dynamic} c - the third value to substitute.
        ' @param {Dynamic} d - the forth value to substitute.
        ' @returns {String} the converted string
        substitute: function(str as string, a = invalid as dynamic, b = invalid as dynamic, c = invalid as dynamic, d = invalid as dynamic) as string
            return substitute(str, m.toString(a), m.toString(b), m.toString(c), m.toString(d))
        end function,

        ' Convert string to boolean.
        ' @param {String} str - the String to convert
        ' @returns {Boolean} the boolean value of the String
        stringToBoolean: function(str as string) as boolean
            if "true" = LCase(str)
                return true
            end if
            return false
        end function,

    }
end function

' This is a convenience function that instantiates and initializes a pseudo class
' Returns invalid if something failed
function initializeObject(objectName as string, params = {} as object) as dynamic
    result = invalid

    'Instantiate object
    objectInstance = CreateObject("roSGNode", objectName)
    isObjectInstantiated = SkySDK_UtilsTypeUtils().isSgNodeSubtype(objectInstance, objectName)

    if isObjectInstantiated
        isObjectInitialized = (objectInstance.callFunc("initialize", params) = true)

        if isObjectInitialized
            result = objectInstance
        else
            'Always call dispose - will fail silently if something went wrong
            objectInstance.callFunc("dispose")
        end if
    end if

    return result
end function