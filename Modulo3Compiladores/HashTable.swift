//
//  HashTable.swift
//  Modulo3Compiladores
//
//  Created by Leo A.Molina on 29/09/26.
//

enum CellState<K: Hashable, V>{
    case empty
    case occupied(node: HashNode<K,V>)
    case deleted
}

struct HashNode<K: Hashable, V> {
    var key: K
    var value: V
    
    init(key: K, value: V) {
        self.key = key
        self.value = value
    }
}

struct HashTable<K: Hashable, V> {
    private var array: [CellState<K,V>] = []
    
    private var capacity: Int = 8 // Using 2^3 as capacity
    private var scaleFactor: Float = 0.75
    private var tombstones: Int = 0
    var count = 0
    
    init() {
        array = Array(repeating: CellState.empty, count: capacity)
    }
    
    mutating func insert(_ key: K, _ value: V) {
        
        rebuild()
        
        var i: Int = 0
        var seen: Int? = nil
        
        while i < capacity {
            let prob = hashFunction(key, i)
            
            switch array[prob] {
                case .empty:
                    if let seen {
                        array[seen] = CellState.occupied(node: HashNode(key: key, value: value))
                        count += 1
                        tombstones -= 1
                        return
                    }
                    array[prob] = CellState.occupied(node: HashNode(key: key, value: value))
                    count += 1
                    return
                    
                case .occupied(node: let node):
                    if key == node.key {
                        array[prob] = CellState.occupied(node: HashNode(key: key, value: value))
                        return
                    }
                    i += 1
                    
                case .deleted:
                    if seen != nil {
                        i += 1
                        continue
                    }
                    seen = prob
                    i += 1
            }
        }
        if let seen {
            array[seen] = CellState.occupied(node: HashNode(key: key, value: value))
            count += 1
            tombstones -= 1
        } else {
            preconditionFailure("Could not insert key")
        }
        
    }
    
    mutating func delete(_ key: K) {
        
        rebuild()
        
        var i = 0
        
        while i < capacity {
            let prob = hashFunction(key, i)
            
            switch array[prob] {
                case .occupied(node: let node):
                    if node.key == key {
                        array[prob] = CellState.deleted
                        count -= 1
                        tombstones += 1
                        return
                    }
                    i += 1
                    
                case .empty:
                    return
                    
                case .deleted:
                    i += 1
            }
        }
    }
    
    func find(_ key: K) -> V? {
        var i = 0
        
        while i < capacity {
            let prob = hashFunction(key, i)
            switch array[prob] {
                case .occupied(node: let node):
                    if node.key == key {
                        return node.value
                    }
                    i += 1
                case .empty:
                    return nil
                    
                case .deleted:
                    i += 1
            }
        }
        return nil
    }
    
    func hashFunction(_ key: K, _ i: Int) -> Int {
        return ((key.hashValue & (capacity - 1)) + i) % capacity
    }
    
    mutating func rebuild() {
        
        guard Float(count + tombstones) / Float(capacity) > scaleFactor else {
            return
        }
        
        var nodes: [HashNode<K,V>] = []
        
        for node in array {
            switch node {
                case .occupied(let node):
                    nodes.append(node)
                default:
                    continue
            }
        }
        
        if tombstones <= count {
            capacity *= 2
        }
        
        array = Array(repeating: CellState<K,V>.empty, count: capacity)
        tombstones = 0
        
        var i: Int = 0
        var prob: Int = 0
        
        // Replacing the nodes in the array
        for node in nodes {
            prob = hashFunction(node.key, i)
            while case .occupied = array[prob] {
                i += 1
                prob = hashFunction(node.key, i)
            }
            i = 0
            array[prob] = CellState.occupied(node: node)
        }
    }
}
