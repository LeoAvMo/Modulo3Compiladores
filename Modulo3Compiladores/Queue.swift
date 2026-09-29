//
//  Queue.swift
//  Modulo3Compiladores
//
//  Created by Leo A.Molina on 28/09/26.
//

import Playgrounds

final class QueueNode<T> {
    var value: T
    var next: QueueNode<T>?
    
    init(value: T, next: QueueNode<T>? = nil) {
        self.value = value
        self.next = next
    }
}

final class QueueStorage<T>: Sequence {
    
    var head: QueueNode<T>?
    var tail: QueueNode<T>?
    
    init() {
        self.head = nil
        self.tail = head
    }
    
    convenience init(values: [T]) {
        self.init()
        for val in values {
            enqueue(val)
        }
    }
    
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator<T>(queue: self)
    }
    
    func enqueue(_ element: T) {
        let current = QueueNode(value: element, next: nil)
        
        if self.isEmpty() {
            head = current
            tail = head
        } else {
            tail!.next = current
            tail = tail!.next
        }
    }
    
    func dequeue() {
        if self.isEmpty() {
            return
        } else if head!.next == nil {
            self.head = nil
            self.tail = head
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
    var current: QueueNode<T>?
    
    init(queue: QueueStorage<T>) {
        self.queue = queue
        current = queue.head
    }
    
    mutating func next() -> T? {
        if current != nil {
            defer {
                current = current?.next
            }
            return current?.value
        }
        return nil
    }
}

struct Queue<T> {
    
    private var storage: QueueStorage<T>
    
    init(_ storage: QueueStorage<T> = QueueStorage()) {
        self.storage = storage
    }
    
    init(values: [T]) {
        self.storage = QueueStorage(values: values)
    }
    
}

#Playground {
    print("Starting iii")
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
