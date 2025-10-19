
' === PUBLIC INTERFACE ===

' --- Methods ---

function initialize(params = {} as object) as boolean
    return m.initialize(params)
end function


function dispose() as void
    m.dispose()
end function



function trace(message as dynamic, level as integer) as void
    m.trace(message, level)
end function

function debug(message as dynamic, level as integer) as void
    m.debug(message, level)
end function

function info(message as dynamic, level as integer) as void
    m.info(message, level)
end function

function warn(message as dynamic, level as integer) as void
    m.warn(message, level)
end function

function error(message as dynamic, level as integer) as void
    m.error(message, level)
end function

function fatal(message as dynamic, level as integer) as void
    m.fatal(message, level)
end function

function init() as void

    ' --- Properties ---

    m.append({
        currentLogLevel: 3
        disableLogging: false
        name: "missingname"
        disableLoggingToScreen: true
    })


    m.initialize = function(options = {} as object) as boolean
        if SkySDK_UtilsTypeUtils().isInt(options.logLevel)
            m.currentLogLevel = options.logLevel
        end if

        if SkySDK_UtilsTypeUtils().isString(options.name)
            m.name = options.name
        end if

        if options?.disableLogging = true
            m.disableLogging = true
        end if

        m.disableLoggingToScreen = true
        if (not m.disableLogging) and SkySDK_UtilsTypeUtils().isBoolean(options?.disableLoggingToScreen)
            m.disableLoggingToScreen = options?.disableLoggingToScreen
        end if

        m.datetime = CreateObject("roDateTime")

        return true
    end function


    m.dispose = function() as void
    end function


    m.trace = function(message as dynamic, level as integer) as void
        if (not m.disableLogging) and (level <= m.currentLogLevel)
            m.datetime.mark()
            m._print(SkySDK_UtilsStringUtils().substitute("{0} [SkySDK - {1}]: {2}", m.datetime.toISOString(), m.name, message))
        end if
    end function

    m.debug = function(message as dynamic, level as integer) as void
        if (not m.disableLogging) and (level <= m.currentLogLevel)
            m.datetime.mark()
            m._print(SkySDK_UtilsStringUtils().substitute("{0} [SkySDK - {1}]: {2}", m.datetime.toISOString(), m.name, message))
        end if
    end function

    m.info = function(message as dynamic, level as integer) as void
        if (not m.disableLogging) and (level <= m.currentLogLevel)
            m.datetime.mark()
            m._print(SkySDK_UtilsStringUtils().substitute("{0} [SkySDK - {1}]: {2}", m.datetime.toISOString(), m.name, message))
        end if
    end function

    m.warn = function(message as dynamic, level as integer) as void
        if (not m.disableLogging) and (level <= m.currentLogLevel)
            m.datetime.mark()
            m._print(SkySDK_UtilsStringUtils().substitute("{0} ** WARNING ** [SkySDK - {1}]: {2}", m.datetime.toISOString(), m.name, message))
        end if
    end function

    m.error = function(message as dynamic, level as integer) as void
        if (not m.disableLogging) and (level <= m.currentLogLevel)
            m.datetime.mark()
            m._print(SkySDK_UtilsStringUtils().substitute("{0} ** ERROR ** [SkySDK - {1}]: {2}", m.datetime.toISOString(), m.name, message))
        end if
    end function

    m.fatal = function(message as dynamic, level as integer) as void
        if (not m.disableLogging) and (level <= m.currentLogLevel)
            m.datetime.mark()
            m._print("")
            m._print(SkySDK_UtilsStringUtils().substitute("{0} ** FATAL ** [SkySDK - {1}]: {2}", m.datetime.toISOString(), m.name, message))
            m._print("")
        end if
    end function

    m._print = function(message as string) as void
        loggingView = getGLobalAA()?.top?.getScene()?.findNode("loggingView")
        if invalid <> loggingView
            loggingView.message = message
        end if
        print message
    end function

end function
