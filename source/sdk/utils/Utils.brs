function SkySDK_Utils_Utils() as Object
    return {
        callFunc: function(Func as Dynamic, args = [] as Object) as Dynamic
            if GetInterface(Func, "ifFunction") <> invalid
                if args = invalid OR args.Count() = 0 then return Func()
                if args.Count() = 1 then return Func(args[0])
                if args.Count() = 2 then return Func(args[0], args[1])
                if args.Count() = 3 then return Func(args[0], args[1], args[2])
                if args.Count() = 4 then return Func(args[0], args[1], args[2], args[3])
                if args.Count() = 5 then return Func(args[0], args[1], args[2], args[3], args[4])
                if args.Count() > 5 then return Func(args[0], args[1], args[2], args[3], args[4], args[5])
            end if
            return invalid
        end function

        callScopedFunc: function(Func as Dynamic, args = [] as Object, destination = object as Dynamic) as Dynamic
            if GetInterface(Func, "ifString") <> invalid AND GetInterface(destination, "ifAssociativeArray") <> invalid AND destination.DoesExist(Func)
                if args = invalid OR args.Count() = 0 then return destination[Func]()
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

function SkySDK_Utils_ArrayUtils() as Object
    return {

        ' Searches for an element that matches the conditions defined by the equality comparer, and returns the first occurrence.
        ' @param context { Dynamic }, context available in EqualityComparerFunc scope
        ' @param array { roArray }, array with the elements to search
        ' @params EqualityComparerFunc { Function(context as Dynamic, el as Dynamic) }, compares values and determines if they are equal
        ' @return { Dynamic }, returns the first element that satisfy the equality comparer condition
        find: function(context as Dynamic, array as Dynamic, EqualityComparerFunc as Dynamic) as Dynamic
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
        contains: function(element as Dynamic, array as Object) as Boolean
            doesExist = SkySDK_Utils_ArrayUtils().find(element, array, function(elementA, elementB)
                return elementA <> invalid AND elementB <> invalid AND elementA = elementB
            end function)
            return doesExist <> invalid
        end function

        ' Performs the specified action defined by Func on each element of the specified array
        ' @param context { Dynamic }, context available in Func scope
        ' @param array { roArray }, array with the elements
        ' @params Func { Function(context as Dynamic, el as Dynamic) }, The Action to perform on each element of array
        forEach: function(context as Dynamic, array as Dynamic, Func as Dynamic) as Void
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
        select: function(context as Dynamic, array as Dynamic, TransformFunc as Dynamic) as Object
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
        where: function(context as Dynamic, array as Dynamic, EqualityComparerFunc as Dynamic) as Object
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
        distinct: function(context as Dynamic, array as Dynamic, EqualityComparerFunc as Dynamic) as Object
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
                        if NOT match then result.Push(array[i])
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
        intersect: function(context as Dynamic, array1 as Dynamic, array2 as Dynamic, EqualityComparerFunc as Dynamic) as Object
            result = []
            if GetInterface(array1, "ifArray") <> invalid AND GetInterface(array2, "ifArray") <> invalid
                for i = 0 to array1.Count() - 1
                    for j = 0 to array2.Count() - 1
                        match = m._execFunc(EqualityComparerFunc, context, [array1[i], array2[j]])
                        if match = true then result.Push(array1[i])
                    end for
                end for
            end if
            return result
        end function

        _execFunc: function(Func as Dynamic, context as Dynamic, args = [] as Object) as Dynamic
            if GetInterface(Func, "ifString") <> invalid AND GetInterface(context, "ifAssociativeArray") <> invalid
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
        copy: function(originalArray as Dynamic) as Object
            result = []
            if GetInterface(originalArray, "ifArray") <> invalid
                result = [] : result.append(originalArray)
                end if
                return result
            end function
        }
    end function

    function SkySDK_Utils_ObjectUtils() as Object
        return {
            ' copies the values and properties from one or more source objects to a target object
            ' @param target { Dynamic }, target to copy the source properties to
            ' @param sources { Dynamic }, sources object/array of objects to copy the properties from
            ' @return { Dynamic }, returns target element merged with the source properties
            assign: function(target as Object, sources = [] as Dynamic) as Dynamic
                if GetInterface(target, "ifAssociativeArray") <> invalid AND sources <> invalid
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
            getPath: function(obj as Dynamic, path as String, defaultValue = invalid as Dynamic) as Dynamic
                if obj <> invalid AND (GetInterface(obj, "ifAssociativeArray") <> invalid OR GetInterface(obj, "ifArray") <> invalid)
                    pathSplit = path.Split("/")
                    property = pathSplit.Shift()

                    if property <> invalid AND property.trim() <> ""
                        if GetInterface(obj, "ifArray") <> invalid
                            r = CreateObject("roRegex", "\[(\d+)\]", "g")
                            arrayMatch = r.Match(property)
                            if arrayMatch <> invalid AND arrayMatch.Count() = 2
                                if pathSplit.Count() = 0
                                    if obj[arrayMatch[1].toInt()] <> invalid then return obj[arrayMatch[1].toInt()]
                                    return defaultValue
                                end if
                                return m.getPath(obj[arrayMatch[1].toInt()], pathSplit.Join("/"), defaultValue)
                            end if
                            return invalid
                        else if GetInterface(obj, "ifAssociativeArray") <> invalid AND obj.DoesExist(property)
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
            hasPath: function(obj as Dynamic, path as String) as Boolean
                return m.getPath(obj, path, invalid) <> invalid
            end function
        }
    end function

    function SkySDK_Utils_DisplayUtils() as Object
        return {
            getDefaultPlayerDimensions: function() as Dynamic
                deviceInfo = skySDK().getDeviceInfo()
                return { width: deviceInfo.uiResolution.width, height: deviceInfo.uiResolution.height, x: 0, y: 0 }
            end function
        }
    end function

    function SkySDK_Utils_URLUtils() as Object
        return {
            parseURLQueryString: function(url as String) as Object
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
    