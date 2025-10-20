' TRACE:  Provides highly detailed information, often including sensitive application data and the execution flow of code.
'         Primarily used for in-depth debugging during development and should generally be disabled in production environments due
'         to verbosity and potential security concerns.
' DEBUG:  Offers detailed information useful for diagnosing issues during development and testing.
'         This level might include API payloads, user preferences, or other granular details to help developers understand and resolve problems.
' INFO:   Confirms that things are working as expected and tracks the general flow of the application.
'         Examples include successful user logins, file uploads, or other routine operations that provide insight into system activity without indicating problems.
' WARN:   Highlights potential issues or unexpected events that do not immediately cause failure but could lead to problems if left unaddressed.
'         This might include approaching a memory limit, using a deprecated function, or other conditions that warrant attention.
' ERROR:  Indicates a significant issue or problem that prevents the application or a specific functionality from performing as expected.
'         This could involve failed API calls, missing required inputs, or other errors that impair operation but may not halt the entire system.
' FATAL:  Represents a severe error that causes the application or a critical system component to become inoperable and potentially halt the entire system.
'         Examples include database connectivity failures or inability to connect to essential services.
function LogLevel() as object
    return {
        TRACE: 5
        DEBUG: 4
        INFO: 3
        WARN: 2
        ERROR: 1
        FATAL: 0
    }
end function

' This is a convenience object that wraps the Utils_Logger node functionality
function newLogger(params = {} as object) as object

    this = {}

    options = {
        disableLogging: params.disableLogging
        logLevel: params.logLevel
        name: params.name
        disableLoggingToScreen: params.disableLoggingToScreen
    }

    if options.disableLogging <> true
        this.logger = initializeObject("Utils_Logger", options)
    end if

    this.options = options

    this.getOptions = function() as object
        return m.options
    end function

    if this.logger <> invalid

        this.trace = function(message as dynamic) as void
            m.logger.callFunc("trace", message, LogLevel().TRACE)
        end function

        this.debug = function(message as dynamic) as void
            m.logger.callFunc("debug", message, LogLevel().DEBUG)
        end function

        this.info = function(message as dynamic) as void
            m.logger.callFunc("info", message, LogLevel().INFO)
        end function

        this.warn = function(message as dynamic) as void
            m.logger.callFunc("warn", message, LogLevel().WARN)
        end function

        this.error = function(message as dynamic) as void
            m.logger.callFunc("error", message, LogLevel().ERROR)
        end function

        this.fatal = function(message as dynamic) as void
            m.logger.callFunc("fatal", message, LogLevel().FATAL)
        end function

    else
        this.trace = function(_ as dynamic) as void
        end function

        this.debug = function(_ as dynamic) as void
        end function

        this.info = function(_ as dynamic) as void
        end function

        this.warn = function(_ as dynamic) as void
        end function

        this.error = function(_ as dynamic) as void
        end function

        this.fatal = function(_ as dynamic) as void
        end function

    end if

    return this
end function

function readConfigFile(filePath as string) as object
    config = ParseJson(ReadAsciiFile(filePath))
    if invalid = config
        config = {
            disableLogging: "false"
            logLevel: false
            name: "Default"
            disableLoggingToScreen: false
        }
    end if
    return {
        "loggerOptions": {
            disableLogging: SkySDK_UtilsStringUtils().stringToBoolean(config?.disableLogging)
            logLevel: config?.logLevel
            name: config?.name
            disableLoggingToScreen: false
        }
    }
end function

function createLoggerOptionsFromParams(params = {} as object) as object
    loggerOptions = params?.loggerOptions

    if not SkySDK_UtilsTypeUtils().isObject(loggerOptions)
        loggerOptions = {}

        _logLevel = params?.logLevel
        if SkySDK_UtilsTypeUtils().isInt(_logLevel)
            loggerOptions.logLevel = _logLevel
        end if

        disableLogging = params?.disableLogging
        if SkySDK_UtilsTypeUtils().isBoolean(disableLogging)
            loggerOptions.disableLogging = disableLogging
        end if

        disableLoggingToScreen = params?.disableLoggingToScreen
        if SkySDK_UtilsTypeUtils().isBoolean(disableLoggingToScreen)
            loggerOptions.disableLoggingToScreen = disableLoggingToScreen
        end if
    else
        _logLevel = loggerOptions.logLevel
        if SkySDK_UtilsTypeUtils().isInt(_logLevel)
            if _logLevel < LogLevel().FATAL
                _logLevel = LogLevel().FATAL
            end if
            if _logLevel > LogLevel().TRACE
                _logLevel = LogLevel().TRACE
            end if
            loggerOptions.logLevel = _logLevel
        else
            loggerOptions.logLevel = LogLevel().TRACE
        end if

        disableLogging = loggerOptions.disableLogging
        if SkySDK_UtilsTypeUtils().isBoolean(disableLogging)
            loggerOptions.disableLogging = disableLogging
        else
            loggerOptions.disableLogging = true
        end if

        disableLoggingToScreen = loggerOptions.disableLoggingToScreen
        if SkySDK_UtilsTypeUtils().isBoolean(disableLoggingToScreen)
            loggerOptions.disableLoggingToScreen = disableLoggingToScreen
        else
            loggerOptions.disableLogging = false
        end if
    end if

    return loggerOptions
end function
