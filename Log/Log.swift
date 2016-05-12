//
//  Log.swift
//  Log
//
//  Created by Evgeny Shurakov on 28.01.16.
//  Copyright © 2016 Evgeny Shurakov. All rights reserved.
//

import Foundation

public class Log {
    public enum Level: Int {
        case Debug = 1
        case Info = 2
        case Warning = 3
        case Error = 4
        case None = 100
    }
    
    public static var defaultLogger: Log?
    
    private let dateFormatter: NSDateFormatter
    private let level: Level
    private let tag: String?
    
    private init() {
        fatalError("Private init")
    }
    
    public init(level: Level, tag: String? = nil) {
        self.level = level
        self.tag = tag
        
        self.dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
    }
    
    public class func d(@autoclosure message: () -> String, function: String = #function) {
        defaultLogger?.d(message, function: function)
    }
    
    public class func i(@autoclosure message: () -> String, function: String = #function) {
        defaultLogger?.i(message, function: function)
    }
    
    public class func w(@autoclosure message: () -> String, function: String = #function) {
        defaultLogger?.w(message, function: function)
    }
    
    public class func e(@autoclosure message: () -> String, function: String = #function) {
        defaultLogger?.e(message, function: function)
    }
    
    public func d(@autoclosure message: () -> String, function: String = #function) {
        log(level: .Debug, message: message, function: function)
    }
    
    public func i(@autoclosure message: () -> String, function: String = #function) {
        log(level: .Info, message: message, function: function)
    }
    
    public func w(@autoclosure message: () -> String, function: String = #function) {
        log(level: .Warning, message: message, function: function)
    }
    
    public func e(@autoclosure message: () -> String, function: String = #function) {
        log(level: .Error, message: message, function: function)
    }
    
    func log(level level: Level, @autoclosure message: () -> String, function: String = #function) {
        if level.rawValue < self.level.rawValue {
            return
        }
        
        let time = self.dateFormatter.stringFromDate(NSDate())
        if let tag = self.tag {
            print("\(time) \(tag)[\(function)]: \(message())")
        } else {
            print("\(time) \(function): \(message())")
        }
    }
}
