//
//  Stack.swift
//  Modulo3Compiladores
//
//  Created by Leo A.Molina on 25/09/26.
//

import Playgrounds

/// StackNode
/// - Properties:
///     - value: Value you  to push into the stack
///     - next: Pointer to following node
indirect enum StackNode<T> {
    case empty
    case node(value: T, next: StackNode)
    
}

/// Stack
/// - Parameters:
///     -
struct Stack<T> {
    var top: StackNode<T> = .empty
    
    init(top: StackNode<T> = .empty) {
        self.top = top
    }
    
    // Building a Stack out of Array
    init(values: [T]) {
        values.forEach { value in
            self.push(value)
        }
    }
    
    // Add error if element to append is not the same value type
    mutating func push(_ element: T) {
        top = .node(value: element, next: top)
    }
    
    mutating func pop() {
        switch top {
            case .empty:
                return
            case .node(let value, let next):
                top = next  // Swift automatically deletes values if there are no references to it due to ARC
        }
    }
}

#Playground {
    
}
