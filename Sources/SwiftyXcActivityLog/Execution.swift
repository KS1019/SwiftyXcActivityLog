//
//  Execution.swift
//  SwiftyXcActivityLog
//
//  Created by Kotaro Suto on 2021/04/10.
//

import Foundation
import Files

public struct Execution: Hashable {
    internal init(time: TimeInterval, file: File?, methodName: String, line: Int, column: Int) {
        self.time = time
        self.file = file
        self.methodName = methodName
        self.line = line
        self.column = column
        
        if self.file == nil {
            isInvalidLocation = true
        }
    }
    
    public var time: TimeInterval
    public var file: File?
    public var isInvalidLocation: Bool = false
    public var methodName: String
    public var line: Int
    public var column: Int
    
    public func hash(into hasher: inout Hasher) {
        if file != nil {
            hasher.combine(file!.path)
        } else {
            hasher.combine("<invalid loc>")
        }
        // hasher.combine(time)
        hasher.combine(line)
        hasher.combine(column)
    }
    
    public static func == (lhs: Execution, rhs: Execution) -> Bool {
        return lhs.file == rhs.file
            && lhs.line == rhs.line
            && lhs.column == rhs.column
    }
}


