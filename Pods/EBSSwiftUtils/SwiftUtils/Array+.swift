//
//  Array+.swift
//
//  Created by Mr. Kittless on 8/21/20.
//  Copyright © 2020 Constantin Breahna. All rights reserved.
//

import Foundation

public extension Array {

    init(repeating: [Element], count: Int) {
        self.init([[Element]](repeating: repeating, count: count).flatMap({ $0 }))
    }
    
    func repeated(count: Int) -> [Element] {
        return [Element](repeating: self, count: count)
    }
    
    subscript (safe index: Int) -> Element? {
        if index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
    
    // usage: array.indexForFirstElement(ofType: ElementType.self)
    /// Returns first index for element of given type, or nil if no elements with given type found;
    func indexForFirstElement<T>(ofType: T.Type) -> Int? {
        for index in 0..<self.count {
            if self[index] is T {
                return index
            }
        }
        return nil
    }
}

public extension Array where Element: Equatable {
    
    /// Delete all elements in array, which are equal to the given element
    mutating func delete(element: Iterator.Element) {
        self = self.filter{$0 != element }
    }
    
    /// Delete all elements in array, which are equal to the given elements
    mutating func delete(elements: [Iterator.Element]) {
        for element in elements {
            self.delete(element: element)
        }
    }
    
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}
