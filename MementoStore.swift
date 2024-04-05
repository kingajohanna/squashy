//
//  MementoStore.swift
//  squashy Watch App
//
//  Created by Szabó Kinga on 22/03/2024.
//

import Foundation

class MementoStore{
    var mementos: [UserPairMemento] = []
    static let max_size: Int = 5
    
    func add_memento(mem: UserPairMemento) {
        if self.mementos.count == MementoStore.max_size {
            self.mementos.removeFirst()
        }
        self.mementos.append(mem)
    }
    
    func get_memento() -> UserPairMemento? {
        guard !mementos.isEmpty else { return nil }
        return mementos.removeLast()
    }
    
    func empty_store() {
        mementos.removeAll()
    }
}

let memento_store = MementoStore()

func get_memento_store() -> MementoStore {
    return memento_store
}
