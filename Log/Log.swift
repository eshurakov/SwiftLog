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
        case Debug = 1
        case Info = 2
        case Warning = 3
        case Error = 4
        case None = 100
    }
    
    public static var defaultLogger: Log?
    
    private let dateFormatter: NSDateFormatter
    
    public let level: Level
    public let tag: String?
    
    private init() {
        fatalError("Private init")
    }
    
    public init(level: Level, tag: String? = nil) {
        self.level = level
        self.tag = tag
        
        self.dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
    }
    
    public class func d(@autoclosure message: () -> String) {
        defaultLogger?.d(message)
    }
    
    public class func i(@autoclosure message: () -> String) {
        defaultLogger?.i(message)
    }
    
    public class func w(@autoclosure message: () -> String) {
        defaultLogger?.w(message)
    }
    
    public class func e(@autoclosure message: () -> String) {
        defaultLogger?.e(message)
    }
    
    public func d(@autoclosure message: () -> String) {
        log(level: .Debug, message: message)
    }
    
    public func i(@autoclosure message: () -> String) {
        log(level: .Info, message: message)
    }
    
    public func w(@autoclosure message: () -> String) {
        log(level: .Warning, message: message)
    }
    
    public func e(@autoclosure message: () -> String) {
        log(level: .Error, message: message)
    }
    
    public func subloggerWithTag(tag: String) -> Log {
        let tag = (self.tag != nil ? self.tag! + "/" : "") + tag
        return Log(level: self.level, tag: tag)
    }
    
    func log(level level: Level, @autoclosure message: () -> String) {
        if level.rawValue < self.level.rawValue {
            return
        }
        
        let time = self.dateFormatter.stringFromDate(NSDate())
        if let tag = self.tag {
            print("\(time) \(tag): \(message())")
        } else {
            print("\(time): \(message())")
        }
    }
}
