//
//  QueueTests.swift
//  Modulo3CompiladoresTests
//
//  Created by Leo A.Molina on 01/10/26.
//

//
//  QueueTests.swift
//

import Testing

//
//  QueueTests.swift
//

@Suite(.serialized)
struct QueueTests {

    @Test("Initialize an empty queue")
    func emptyInitialization() {
        print("\nTest description: Initialize an empty queue")
        print("""
        Code used for the test:
        let queue = Queue<Int>()
        #expect(queue.isEmpty())
        #expect(queue.getHead() == nil)
        #expect(queue.getTail() == nil)
        """)
        
        let queue = Queue<Int>()
        
        let passed = queue.isEmpty() && queue.getHead() == nil && queue.getTail() == nil
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(queue.isEmpty())
        #expect(queue.getHead() == nil)
        #expect(queue.getTail() == nil)
    }

    @Test("Initialize a queue from an array")
    func arrayInitialization() {
        print("\nTest description: Initialize a queue from an array")
        print("""
        Code used for the test:
        let queue = Queue(values: [1, 2, 3])
        #expect(!queue.isEmpty())
        #expect(queue.getHead() == 1)
        #expect(queue.getTail() == 3)
        """)
        
        let queue = Queue(values: [1, 2, 3])
        
        let passed = !queue.isEmpty() && queue.getHead() == 1 && queue.getTail() == 3
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(!queue.isEmpty())
        #expect(queue.getHead() == 1)
        #expect(queue.getTail() == 3)
    }

    @Test("Enqueue elements to the queue")
    func enqueue() {
        print("\nTest description: Enqueue elements to the queue")
        print("""
        Code used for the test:
        var queue = Queue<String>()
        queue.enqueue("A")
        queue.enqueue("B")
        #expect(queue.getHead() == "A")
        #expect(queue.getTail() == "B")
        """)
        
        var queue = Queue<String>()
        queue.enqueue("A")
        let firstCheck = queue.getHead() == "A" && queue.getTail() == "A"
        queue.enqueue("B")
        
        let passed = firstCheck && queue.getHead() == "A" && queue.getTail() == "B"
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(queue.getHead() == "A")
        #expect(queue.getTail() == "B")
    }

    @Test("Dequeue elements from the queue")
    func dequeue() {
        print("\nTest description: Dequeue elements from the queue")
        print("""
        Code used for the test:
        var queue = Queue(values: [10, 20])
        queue.dequeue()
        queue.dequeue()
        queue.dequeue() // Should not crash
        #expect(queue.isEmpty())
        """)
        
        var queue = Queue(values: [10, 20])
        queue.dequeue()
        let firstCheck = queue.getHead() == 20 && queue.getTail() == 20
        queue.dequeue()
        let secondCheck = queue.isEmpty()
        queue.dequeue()
        
        let passed = firstCheck && secondCheck && queue.isEmpty()
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(queue.isEmpty())
    }

    @Test("Iterate through the queue using Sequence")
    func sequenceIteration() {
        print("\nTest description: Iterate through the queue using Sequence")
        print("""
        Code used for the test:
        let values = [5, 10, 15]
        let queue = Queue(values: values)
        var result: [Int] = []
        for value in queue { result.append(value) }
        #expect(result == values)
        """)
        
        let values = [5, 10, 15]
        let queue = Queue(values: values)
        var result: [Int] = []
        
        for value in queue {
            result.append(value)
        }
        
        let passed = result == values
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(result == values)
    }

    @Test("Verify Copy-on-Write value semantics")
    func valueSemantics() {
        print("\nTest description: Verify Copy-on-Write value semantics")
        print("""
        Code used for the test:
        var queue1 = Queue(values: [1, 2])
        var queue2 = queue1
        queue2.enqueue(3)
        queue2.dequeue()
        #expect(queue1.getTail() == 2)
        #expect(queue2.getTail() == 3)
        """)
        
        let queue1 = Queue(values: [1, 2])
        var queue2 = queue1
        
        queue2.enqueue(3)
        queue2.dequeue()
        
        let passed = queue1.getHead() == 1 && queue1.getTail() == 2 && queue2.getHead() == 2 && queue2.getTail() == 3
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(queue1.getHead() == 1)
        #expect(queue1.getTail() == 2)
        #expect(queue2.getHead() == 2)
        #expect(queue2.getTail() == 3)
    }
}
