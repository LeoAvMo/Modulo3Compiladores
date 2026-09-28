//
//  Stack.swift
//  Modulo3Compiladores
//
//  Created by Leo A.Molina on 25/09/26.
//

/// A stack's node that can hold a value
/// # States
/// ## Empty
/// Indicates the node has no value
/// ## Node
/// Indicates the node has a value and is linked to another node
/// ### Associated values
/// - value: The value that the node holds
/// - next: The next node it is pointing to
indirect enum StackNode<T> {
    case empty
    case node(value: T, next: StackNode)
    
}

/// A Last-Int, First-Out (LIFO) data structure.
///
/// This implementation uses enums instead of classes for the nodes to follow Swift's value semantics instead of reference semantics.
///
/// # Operations
/// ## Push
/// Inserts an item on top of the stack in *O(1)*.
/// ## Pop
/// Deletes the item on top of the stack in *O(1)*.
/// ## getTop
/// Returns the value on top of the stack if it's not empty in *O(1)*.
/// ## printStack
/// Prints the stack top to bottom in *O(n)*.
struct Stack<T>: Sequence {
    
    /// Top-most node
    var top: StackNode<T> = .empty
    
    /// Basic initializer
    init(_ top: StackNode<T> = .empty) {
        self.top = top
    }
    
    /// Initializer based in an array
    init(values: [T]) {
        values.forEach { value in
            self.push(value)
        }
    }
    
    /// Used for stack iteration (not passed by reference)
    func makeIterator() -> StackIterator<T> {
        return StackIterator(stack: self)
    }
    
    /// Pushes an element at the top of the stack.
    /// - Parameters:
    ///     - element: The element to be pushed.
    mutating func push(_ element: T) {
        top = .node(value: element, next: top)
    }
    
    /// Deletes the element at the top of the stack.
    mutating func pop() {
        switch top {
            case .empty:
                return
            case .node(let value, let next):
                top = next
        }
    }
    
    /// Returns the element at the top of the stack.
    func getTop() -> T? {
        switch top {
            case .empty:
                return nil
            case .node(let value, let next):
                return value
        }
    }
    
    /// Prints the stack from top to bottom.
    func printStack() {
        var current = top
        
        while case let .node(value, next) = current {
            print(value)
            current = next
        }
    }

}

/// Iterator for the stack
struct StackIterator<T>: IteratorProtocol {
    
    var stack: Stack<T>
    
    init(stack: Stack<T>) {
        self.stack = stack
    }
    
    mutating func next() -> T? {
        if case let .node(value, next) = stack.top {
            defer { stack.top = next }
            return value
        } else {
            return nil
        }
    }
    
}

