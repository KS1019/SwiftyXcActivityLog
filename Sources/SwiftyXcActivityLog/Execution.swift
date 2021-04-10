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
    
    var time: TimeInterval
    var file: File?
    var isInvalidLocation: Bool = false
    var methodName: String
    var line: Int
    var column: Int
    
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


