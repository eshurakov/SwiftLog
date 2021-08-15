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
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMddHHmmssSSS")
    }
    
    public class func d(_ message: @autoclosure () -> String) {
        defaultLogger?.d(message())
    }
    
    public class func i(_ message: @autoclosure () -> String) {
        defaultLogger?.i(message())
    }
    
    public class func w(_ message: @autoclosure () -> String) {
        defaultLogger?.w(message())
    }
    
    public class func e(_ message: @autoclosure () -> String) {
        defaultLogger?.e(message())
    }
    
    public func d(_ message: @autoclosure () -> String) {
        log(level: .debug, message: message())
    }
    
    public func i(_ message: @autoclosure () -> String) {
        log(level: .info, message: message())
    }
    
    public func w(_ message: @autoclosure () -> String) {
        log(level: .warning, message: message())
    }
    
    public func e(_ message: @autoclosure () -> String) {
        log(level: .error, message: message())
    }
    
	public func subloggerWithTag(tag: String) -> Log {
        let tag = (self.tag != nil ? self.tag! + "/" : "") + tag
        return Log(level: self.level, tag: tag)
    }

    func log(level: Level, message: @autoclosure () -> String) {
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
