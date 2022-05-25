//
//  RxSwift+.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import RxRelay

extension BehaviorRelay {
    
    func append<T>(_ element: T) where Element == [T] {
        self.accept(self.value + [element])
    }
    
    func append<T>(contentsOf newElements: [T]) where Element == [T] {
        self.accept(self.value + newElements)
    }
    
    @discardableResult
    func remove<T>(at index: Int) -> T where Element == [T] {
        var value = self.value
        let removedValue = value.remove(at: index)
        
        self.accept(value)
        return removedValue
    }
}
