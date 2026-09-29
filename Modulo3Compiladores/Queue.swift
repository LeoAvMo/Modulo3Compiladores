//
//  Queue.swift
//  Modulo3Compiladores
//
//  Created by Leo A.Molina on 28/09/26.
//

import Playgrounds

class QueueNode<T> {
    var value: T
    var next: QueueNode<T>?
    
    init(value: T, next: QueueNode<T>? = nil) {
        self.value = value
        self.next = next
    }
}

struct QueueStorage<T>: Sequence {
    
    var head: QueueNode<T>?
    var tail: QueueNode<T>?
    
    init() {
        self.head = nil
        self.tail = head
    }
    
    init(values: [T]) {
        self.init()
        for value in values {
            self.enqueue(value)
        }
    }
    
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator<T>(queue: self)
    }
    
    mutating func enqueue(_ element: T) {
        let current = QueueNode(value: element, next: nil)
        
        if self.isEmpty() {
            head = current
            tail = head
        } else {
            tail!.next = current
            tail = tail!.next
        }
    }
    
    mutating func dequeue() {
        if self.isEmpty() {
            return
        } else if head!.next == nil {
            self = .init()
        } else {
            head = head!.next
        }
    }
    
    func getHead() -> T? {
        return head?.value
    }
    
    func getTail() -> T? {
        return tail?.value
    }
    
    func isEmpty() -> Bool {
        return head == nil
    }
    
    func printQueue() {
        var current = head
        while current != nil {
            print(current!.value)
            current = current?.next
        }
    }
}

struct QueueIterator<T>: IteratorProtocol {
    var queue: QueueStorage<T>
    
    init(queue: QueueStorage<T>) {
        self.queue = queue
    }
    
    mutating func next() -> T? {
        if queue.head != nil {
            defer {
                queue.head = queue.head?.next
            }
            return queue.head?.value
        }
        return nil
    }
}

#Playground {
    print("Starting")
    var q = QueueStorage(values: [1,2,3,4])
    print("All values")
    for i in q {
        print(i)
    }
    print("Values")
    q.printQueue()
    q.dequeue()
    q.dequeue()
    q.dequeue()
    q.dequeue()
    q.dequeue()
    print("After dequeue")
    q.printQueue()
    print("After enqueue")
    q.enqueue(1)
    q.enqueue(1)
    q.enqueue(1)
    q.printQueue()
}
