//
//  Queue.swift
//  Modulo3Compiladores
//
//  Created by Leo A.Molina on 28/09/26.
//

/// A queue's node for a linked list implementation
final class QueueNode<T> {
    var value: T
    var next: QueueNode<T>?
    
    init(value: T, next: QueueNode<T>? = nil) {
        self.value = value
        self.next = next
    }
    
}

/// The storage for a First-In, First-Out (FIFO) data structure.
///
/// This is only the storage for the data structure that holds the nodes and methods that are not read only which actually modify the data structure.
///
/// # Operations
/// ## Enqueue
/// Inserts an element into the last position of the queue in *O(1)*.
/// ## Dequeue
/// Deletes the first element from the queue in *O(1)*.
/// # Copy
/// Creates a copy of the current queue in *O(n)*. Used only for passing by value the data structure.
final class QueueStorage<T>{
    
    var head: QueueNode<T>?
    var tail: QueueNode<T>?
    
    init() {
        self.head = nil
        self.tail = head
    }
    
    func enqueue(_ element: T) {
        let current = QueueNode(value: element, next: nil)
        
        if head == nil {
            head = current
            tail = head
        } else {
            tail!.next = current
            tail = tail!.next
        }
    }
    
    func dequeue() {
        if head == nil {
            return
        } else if head!.next == nil {
            head = nil
            tail = head
        } else {
            head = head!.next
        }
    }
    
    func copy() -> QueueStorage {
        var current = head
        let queue = QueueStorage()
        
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

/// A First-In, First-Out (FIFO) data structure
///
/// This structure encapsulates the QueueStorage class to pass by value the queue, using Swift's value semantics.
///
/// # Operations
/// ## Enqueue
/// Inserts an element into the last position of the queue in *O(1)*.
/// ## Dequeue
/// Deletes the first element from the queue in *O(1)*.
/// ## getHead
/// Returns the queue's current first value in *O(1)*. Returns a nil in case the queue is empty.
/// ## getTail
/// Returns the queue's current last value in *O(1)*. Returns a nil in case the queue is empty.
/// ## isEmpty
/// Returns a boolean that indicates if the queue is empty.
/// ## printQueue
/// Prints the queue from first to last element.
struct Queue<T>: Sequence {
    
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
        self.storage.enqueue(element)
    }
    
    mutating func dequeue() {
        guard !self.isEmpty() else {
            return
        }
        checkReferences()
        self.storage.dequeue()
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
