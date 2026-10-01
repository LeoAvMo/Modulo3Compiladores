//
//  StackTests.swift
//  Modulo3CompiladoresTests
//
//  Created by Leo A.Molina on 01/10/26.
//

//
//  StackTests.swift
//

import Testing

struct StackTests {

    @Test("Initialize an empty stack")
    func emptyInitialization() {
        print("\nTest description: Initialize an empty stack")
        print("""
        Code used for the test:
        let stack = Stack<Int>()
        #expect(stack.getTop() == nil)
        """)
        
        let stack = Stack<Int>()
        
        let passed = stack.getTop() == nil
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(stack.getTop() == nil)
    }

    @Test("Initialize a stack from an array")
    func arrayInitialization() {
        print("\nTest description: Initialize a stack from an array")
        print("""
        Code used for the test:
        let stack = Stack(values: [1, 2, 3])
        #expect(stack.getTop() == 3)
        """)
        
        let stack = Stack(values: [1, 2, 3])
        
        let passed = stack.getTop() == 3
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(stack.getTop() == 3)
    }

    @Test("Push elements onto the stack")
    func push() {
        print("\nTest description: Push elements onto the stack")
        print("""
        Code used for the test:
        var stack = Stack<String>()
        stack.push("First")
        stack.push("Second")
        #expect(stack.getTop() == "Second")
        """)
        
        var stack = Stack<String>()
        stack.push("First")
        let firstCheck = stack.getTop() == "First"
        
        stack.push("Second")
        
        let passed = firstCheck && stack.getTop() == "Second"
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(stack.getTop() == "Second")
    }

    @Test("Pop elements from the stack")
    func pop() {
        print("\nTest description: Pop elements from the stack")
        print("""
        Code used for the test:
        var stack = Stack(values: [10, 20])
        stack.pop()
        stack.pop()
        stack.pop() // Should not crash
        #expect(stack.getTop() == nil)
        """)
        
        var stack = Stack(values: [10, 20])
        let firstCheck = stack.getTop() == 20
        
        stack.pop()
        let secondCheck = stack.getTop() == 10
        
        stack.pop()
        let thirdCheck = stack.getTop() == nil
        
        stack.pop()
        
        let passed = firstCheck && secondCheck && thirdCheck && stack.getTop() == nil
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(stack.getTop() == nil)
    }

    @Test("Iterate through the stack using Sequence")
    func sequenceIteration() {
        print("\nTest description: Iterate through the stack using Sequence")
        print("""
        Code used for the test:
        let stack = Stack(values: [1, 2, 3])
        var result: [Int] = []
        for value in stack { result.append(value) }
        #expect(result == [3, 2, 1])
        """)
        
        let stack = Stack(values: [1, 2, 3])
        var result: [Int] = []
        
        for value in stack {
            result.append(value)
        }
        
        let passed = result == [3, 2, 1]
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(result == [3, 2, 1])
    }

    @Test("Verify value semantics")
    func valueSemantics() {
        print("\nTest description: Verify value semantics")
        print("""
        Code used for the test:
        var stack1 = Stack(values: ["A", "B"])
        var stack2 = stack1
        stack2.push("C")
        stack2.pop()
        stack2.pop()
        #expect(stack1.getTop() == "B")
        #expect(stack2.getTop() == "A")
        """)
        
        let stack1 = Stack(values: ["A", "B"])
        var stack2 = stack1
        
        stack2.push("C")
        stack2.pop()
        stack2.pop()
        
        let passed = stack1.getTop() == "B" && stack2.getTop() == "A"
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(stack1.getTop() == "B")
        #expect(stack2.getTop() == "A")
    }
}
