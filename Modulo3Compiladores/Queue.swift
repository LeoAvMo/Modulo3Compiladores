//
//  Queue.swift
//  Modulo3Compiladores
//
//  Created by Leo A.Molina on 28/09/26.
//

import Playgrounds

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
    
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator(queue: self)
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

struct QueueIterator<T>: IteratorProtocol {
    var queue: Queue<T>
    
    init(queue: Queue<T>) {
        self.queue = queue
    }
    
    mutating func next() -> T? {
        
        if !queue.isEmpty() && queue.head.next != nil {
            defer {
                queue.head = queue.head.next!
            }
            return queue.head.value
        } else if !queue.isEmpty() && queue.head.next == nil {
            defer { queue.head.value = nil }
            return queue.head.value
        } else {
            return nil
        }
    }
}

#Playground {
    var q = Queue(values: [1,2,3,4])
    for val in q {
        print(val)
    }
}
