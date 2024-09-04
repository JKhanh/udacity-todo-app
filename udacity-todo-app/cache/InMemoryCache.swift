//
//  InMemoryCache.swift
//  udacity-todo-app
//
//  Created by Khanh on 30/8/24.
//

import Foundation

class InMemoryCache: Cache {
    var todoList: [Todo] = []
    
    func save(todo: Todo) {
        todoList.append(todo)
    }
    
    func load() -> [Todo] {
        todoList
    }
}
