//
//  Extensions.swift
//  SwiftyXcActivityLog
//
//  Created by Kotaro Suto on 2021/04/10.
//

import Foundation

// Ref: https://www.donnywals.com/removing-duplicate-values-from-an-array-in-swift/
extension Array where Element: Hashable {
    public func uniqueElements(noUnique: Bool = true) -> [Element] {
        guard !noUnique else { return self }
        var seen = Set<Element>()
        
        return self.compactMap { element in
            guard !seen.contains(element)
            else { return nil }
            
            seen.insert(element)
            return element
        }
    }
}

extension String {
    func readByPattern() -> Bool {
        let pattern = "^[0-9.]+ms\\s+.+?\\s+.+$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { print("NSRegularExpression failed");return false }
        let matches = regex.numberOfMatches(in: self, options:[],range: NSRange(location: 0, length: self.count))
        return matches > 0
    }
}
