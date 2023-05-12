//
// File: WriteLog.swift
// Package: RC Flight Log
// Created by: Steven Barnett on 21/02/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import SwiftUI

public enum LogTag: CaseIterable {
    case error
    case warning
    case success
    case debug
    case network
    case info
    
    public var label: String {
        switch self {
        case .error: return "🔴 ERROR"
        case .warning: return "🟠 WARNING"
        case .success: return "🟢 SUCCESS"
        case .debug: return "🟣 DEBUG"
        case .network: return "🟡 NETWORK"
        case .info: return "🔷 INFO"
        }
    }
}

public class WriteLog {
    
    private static var OSLogLevel: LogTag? = nil
    
    public class func setOSLoggingLevel(_ level: LogTag) {
        OSLogLevel = level
    }
    public class func clearOSLogging() {
        OSLogLevel = nil
    }
    
    // MARK: - Public Interface
    
    public class func log(tag: LogTag,
                          _ items: Any...,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line,
                     separator: String = " ") {
        writeLog(tag: tag, items, file: file, function: function, line: line, separator: separator)
    }
    
    public class func error(_ items: Any...,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line,
                     separator: String = " ") {
        writeLog(tag: .error, items, file: file, function: function, line: line, separator: separator)
    }
    
    public class func warning(_ items: Any...,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line,
                       separator: String = " ") {
        writeLog(tag: .warning, items, file: file, function: function, line: line, separator: separator)
    }
    
    public class func success(_ items: Any...,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line,
                       separator: String = " ") {
        writeLog(tag: .success, items, file: file, function: function, line: line, separator: separator)
    }
    
    public class func debug(_ items: Any...,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line,
                     separator: String = " ") {
        writeLog(tag: .debug, items, file: file, function: function, line: line, separator: separator)
    }
    
    public class func network(_ items: Any...,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line,
                       separator: String = " ") {
        writeLog(tag: .network, items, file: file, function: function, line: line, separator: separator)
    }
    
    public class func info(_ items: Any...,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line,
                    separator: String = " ") {
        writeLog(tag: .info, items, file: file, function: function, line: line, separator: separator)
    }
    
    // MARK: - Logging function
    
    private class func writeLog(tag: LogTag = .debug,
                                _ items: Any...,
                                file: String,
                                function: String,
                                line: Int,
                                separator: String = " ") {
        
        // TODO: Test OSLogLevel and write log message to the OS log if necessary
        
#if DEBUG
        let functionName = functionName(function, in: file, at: line)
        let timestamp = logTime()
        let output = content(items, separator: separator)
        
        var msg = "\(timestamp) \(tag.label) \(functionName) : "
        if !output.isEmpty { msg += "\(output)" }
        
        print(msg)
#endif
    }
    
    private class func functionName(_ function: String, in file: String, at line: Int) -> String {
        let shortFile = file.components(separatedBy: "/").last ?? "---"
        let fileName = (shortFile as NSString).deletingPathExtension
        
        return "\(fileName).\(function):\(line)"
    }
    
    private class func logTime() -> String {
        let df = DateFormatter()
        df.dateFormat = "H:mm:ss.SSS"
        return df.string(from: Date.now)
    }
    
    private class func content(_ items: Any..., separator: String = " ") -> String {
        items.map {
            if let itm = $0 as? CustomStringConvertible {
                return "\(itm.description)"
            } else {
                return "\($0)"
            }
        }.joined(separator: separator)
    }
}
