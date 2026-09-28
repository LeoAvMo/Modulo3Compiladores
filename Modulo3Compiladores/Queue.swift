//
//  Queue.swift
//  Modulo3Compiladores
//
//  Created by Leo A.Molina on 28/09/26.
//

class QueueNode<T> {
    var value: T?
    var next: QueueNode?
    
    init(value: T? = nil, next: QueueNode? = nil) {
        self.value = value
        self.next = next
    }
}

struct Queue<T>: Sequence {
    
    var head: QueueNode<T>
    var tail: QueueNode<T>
    
    init() {
        self.head = QueueNode(value: nil, next: nil)
        self.tail = head
    }
    
    init(values: [T]) {
        self.init()
        for value in values {
            self.enqueue(value)
        }
    }
    
    func makeIterator() -> QueueIterator {
        
    }
    
    mutating func enqueue(_ element: T) {
        if self.isEmpty() {
            let current = QueueNode(value: element, next: nil)
            head = current
            tail = head
        } else {
            let current = QueueNode(value: element, next: nil)
            tail.next = current
            tail = current
        }
    }
    
    mutating func dequeue() {
        if self.isEmpty() {
            return
        } else if head.value != nil && head.next == nil {
            self = .init()
        } else {
            head = head.next!
        }
    }
    
    func getHead() -> T? {
        return head.value
    }
    
    func getTail() -> T? {
        return tail.value
    }
    
    func isEmpty() -> Bool {
        return head.value == nil && head.next == nil
    }
    
    func printQueue() {
        var current = head
        while current.value != nil {
            print(current.value!)
            if current.next == nil {
                return
            } else {
                current = current.next!
            }
        }
    }
}

struct QueueIterator: IteratorProtocol {
    var
}
