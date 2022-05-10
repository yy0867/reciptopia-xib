//
//  Log.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import Foundation

class Log {
    
    static func print(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        Swift.print("####################")
        Swift.print("# Log at \(Date())")
        Swift.print("# \(file) - \(function) (line \(line))")
        Swift.print(items)
        Swift.print("####################")
    }
    
    static func getLocation(file: String = #file, function: String = #function, line: Int = #line) -> String {
        return "\(file) - \(function) (line \(line))"
    }
}
