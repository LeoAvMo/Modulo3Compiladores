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

final class QueueStorage<T>{
    
    var head: QueueNode<T>?
    var tail: QueueNode<T>?
    
    init() {
        self.head = nil
        self.tail = head
    }
    
    func isEmpty() -> Bool {
        return head == nil
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
    
    func copy() -> QueueStorage {
        var current = head
        var queue = QueueStorage()
        while current != nil {
            queue.enqueue(current!.value)
            current = current?.next
        }
        return queue
    }
}

struct QueueIterator<T>: IteratorProtocol {
    var current: QueueNode<T>?
    
    init(current: QueueNode<T>?) {
        self.current = current
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

struct Queue<T>: Sequence{
    
    private var storage: QueueStorage<T>
    
    init() {
        self.storage = QueueStorage()
    }
    
    init(values: [T]) {
        self.storage = QueueStorage()
        for value in values {
            self.enqueue(value)
        }
    }
    
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator<T>(current: storage.head)
    }
    
    private mutating func checkReferences() {
        if !isKnownUniquelyReferenced(&self.storage) {
            self.storage = storage.copy()
        }
    }
    
    mutating func enqueue(_ element: T) {
        checkReferences()
        let current = QueueNode(value: element, next: nil)
        
        if self.isEmpty() {
            storage.head = current
            storage.tail = storage.head
        } else {
            storage.tail!.next = current
            storage.tail = storage.tail!.next
        }
    }
    
    mutating func dequeue() {
        checkReferences()
        if self.isEmpty() {
            return
        } else if storage.head!.next == nil {
            storage.head = nil
            storage.tail = storage.head
        } else {
            storage.head = storage.head!.next
        }
    }
    
    func getHead() -> T? {
        storage.head?.value
    }
    
    func getTail() -> T? {
        storage.tail?.value
    }
    
    func isEmpty() -> Bool {
        return storage.head == nil
    }
    
    func printQueue() {
        var current = storage.head
        while current != nil {
            print(current!.value)
            current = current?.next
        }
    }
    
}

#Playground {
    
    var q = Queue(values: [1,2,3,4])
    var a = q
    a.dequeue()
    
    print("q queue")
    for val in q {
        print(val)
    }
    print("a queue")
    for val in a {
        print(val)
    }
}
