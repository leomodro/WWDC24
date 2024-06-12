//
//  Sequence+Extension.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { first, second in
            return first[keyPath: keyPath] < second[keyPath: keyPath]
        }
    }
}
