//
//  HashTableTests.swift
//  Modulo3CompiladoresTests
//
//  Created by Leo A.Molina on 01/10/26.
//

//
//  HashTableTests.swift
//

import Testing

@Suite(.serialized)
struct HashTableTests {

    @Test("Insert and find key-value pairs")
    func insertAndFind() {
        print("\nTest description: Insert and find key-value pairs")
        print("""
        Code used for the test:
        var hashTable = HashTable<String, Int>()
        hashTable.insert("One", 1)
        hashTable.insert("Two", 2)
        #expect(hashTable.find("One") == 1)
        #expect(hashTable.find("Two") == 2)
        #expect(hashTable.find("Three") == nil)
        """)
        
        var hashTable = HashTable<String, Int>()
        hashTable.insert("One", 1)
        hashTable.insert("Two", 2)
        
        let passed = hashTable.find("One") == 1 && hashTable.find("Two") == 2 && hashTable.find("Three") == nil
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(hashTable.find("One") == 1)
        #expect(hashTable.find("Two") == 2)
        #expect(hashTable.find("Three") == nil)
    }

    @Test("Update an existing key's value")
    func updateExistingKey() {
        print("\nTest description: Update an existing key's value")
        print("""
        Code used for the test:
        var hashTable = HashTable<String, String>()
        hashTable.insert("Key", "Initial")
        hashTable.insert("Key", "Updated")
        #expect(hashTable.find("Key") == "Updated")
        #expect(hashTable.count == 1)
        """)
        
        var hashTable = HashTable<String, String>()
        hashTable.insert("Key", "Initial")
        let firstCheck = hashTable.find("Key") == "Initial"
        
        hashTable.insert("Key", "Updated")
        
        let passed = firstCheck && hashTable.find("Key") == "Updated" && hashTable.count == 1
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(hashTable.find("Key") == "Updated")
        #expect(hashTable.count == 1)
    }

    @Test("Delete a key-value pair")
    func delete() {
        print("\nTest description: Delete a key-value pair")
        print("""
        Code used for the test:
        var hashTable = HashTable<Int, String>()
        hashTable.insert(1, "A")
        hashTable.insert(2, "B")
        hashTable.delete(1)
        hashTable.delete(99) // Non-existent key
        #expect(hashTable.find(1) == nil)
        #expect(hashTable.find(2) == "B")
        #expect(hashTable.count == 1)
        """)
        
        var hashTable = HashTable<Int, String>()
        hashTable.insert(1, "A")
        hashTable.insert(2, "B")
        
        hashTable.delete(1)
        hashTable.delete(99)
        
        let passed = hashTable.find(1) == nil && hashTable.find(2) == "B" && hashTable.count == 1
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(hashTable.find(1) == nil)
        #expect(hashTable.find(2) == "B")
        #expect(hashTable.count == 1)
    }

    @Test("Handle tombstone state correctly during insertion and lookup")
    func tombstoneHandling() {
        print("\nTest description: Handle tombstone state correctly during insertion and lookup")
        print("""
        Code used for the test:
        var hashTable = HashTable<String, Int>()
        hashTable.insert("A", 1)
        hashTable.insert("B", 2)
        hashTable.delete("A")
        hashTable.insert("C", 3)
        #expect(hashTable.find("A") == nil)
        #expect(hashTable.find("B") == 2)
        #expect(hashTable.find("C") == 3)
        """)
        
        var hashTable = HashTable<String, Int>()
        hashTable.insert("A", 1)
        hashTable.insert("B", 2)
        
        hashTable.delete("A")
        hashTable.insert("C", 3)
        
        let findA = hashTable.find("A")
        let findB = hashTable.find("B")
        let findC = hashTable.find("C")
        
        let passed = findA == nil && findB == 2 && findC == 3
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(findA == nil)
        #expect(findB == 2)
        #expect(findC == 3)
    }

    @Test("Rebuild and scale the hash table capacity")
    func rebuildAndResize() {
        print("\nTest description: Rebuild and scale the hash table capacity")
        print("""
        Code used for the test:
        var hashTable = HashTable<Int, Int>()
        for i in 1...10 { hashTable.insert(i, i * 10) }
        #expect(hashTable.count == 10)
        """)
        
        var hashTable = HashTable<Int, Int>()
        
        for i in 1...10 {
            hashTable.insert(i, i * 10)
        }
        
        var allMatch = true
        for i in 1...10 {
            if hashTable.find(i) != i * 10 {
                allMatch = false
            }
        }
        
        let passed = hashTable.count == 10 && allMatch
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(hashTable.count == 10)
        for i in 1...10 {
            #expect(hashTable.find(i) == i * 10)
        }
    }
    
    @Test("Rebuild the hash table from accumulated tombstones")
    func rebuildFromTombstones() {
        print("\nTest description: Rebuild the hash table from accumulated tombstones")
        print("""
        Code used for the test:
        var hashTable = HashTable<Int, Int>()
        for i in 1...5 { hashTable.insert(i, i) }
        for i in 1...4 { hashTable.delete(i) }
        hashTable.insert(6, 6)
        hashTable.insert(7, 7)
        #expect(hashTable.find(1) == nil)
        #expect(hashTable.find(7) == 7)
        """)
        
        var hashTable = HashTable<Int, Int>()
        
        for i in 1...5 {
            hashTable.insert(i, i)
        }
        for i in 1...4 {
            hashTable.delete(i)
        }
        
        hashTable.insert(6, 6)
        hashTable.insert(7, 7)
        
        let passed = hashTable.find(1) == nil && hashTable.find(5) == 5 && hashTable.find(6) == 6 && hashTable.find(7) == 7
        print(passed ? "Passed ✅" : "Failed ❌")
        
        #expect(hashTable.find(1) == nil)
        #expect(hashTable.find(5) == 5)
        #expect(hashTable.find(6) == 6)
        #expect(hashTable.find(7) == 7)
    }
}
