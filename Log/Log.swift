//
//  Log.swift
//  Log
//
//  Created by Evgeny Shurakov on 28.01.16.
//  Copyright © 2016 Evgeny Shurakov. All rights reserved.
//

import Foundation

public final class Log {
    public enum Level: Int {
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        case none = 100
    }
    
    public static var defaultLogger: Log?
    
    private let dateFormatter: DateFormatter

    public let level: Level
    public let tag: String?
    
    private init() {
        fatalError("Private init")
    }
    
    public init(level: Level, tag: String? = nil) {
        self.level = level
        self.tag = tag
        
        self.dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
    }
    
    public class func d(_ message: @autoclosure () -> String, function: String = #function) {
        defaultLogger?.d(message, function: function)
    }
    
    public class func i(_ message: @autoclosure () -> String, function: String = #function) {
        defaultLogger?.i(message, function: function)
    }
    
    public class func w(_ message: @autoclosure () -> String, function: String = #function) {
        defaultLogger?.w(message, function: function)
    }
    
    public class func e(_ message: @autoclosure () -> String, function: String = #function) {
        defaultLogger?.e(message, function: function)
    }
    
    public func d(_ message: @autoclosure () -> String, function: String = #function) {
        log(level: .debug, message: message, function: function)
    }
    
    public func i(_ message: @autoclosure () -> String, function: String = #function) {
        log(level: .info, message: message, function: function)
    }
    
    public func w(_ message: @autoclosure () -> String, function: String = #function) {
        log(level: .warning, message: message, function: function)
    }
    
    public func e(_ message: @autoclosure () -> String, function: String = #function) {
        log(level: .error, message: message, function: function)
    }
    
	public func subloggerWithTag(tag: String) -> Log {
        let tag = (self.tag != nil ? self.tag! + "/" : "") + tag
        return Log(level: self.level, tag: tag)
    }

    func log(level: Level, message: @autoclosure () -> String, function: String = #function) {
        if level.rawValue < self.level.rawValue {
            return
        }
        
        let time = self.dateFormatter.string(from: Date())
        if let tag = self.tag {
            print("\(time) \(tag): \(message())")
        } else {
            print("\(time): \(message())")
        }
    }
}
