//
//  TodosManager.swift
//  udacity-todo-app
//
//  Created by Khanh on 29/8/24.
//

import Foundation

enum ListError: Error {
    case illigalIndex
    case notFound
}

class TodosManager {
    private var cacheSystem: Cache = InMemoryCache()
    
    func setCacheSystem(system: Cache) {
        cacheSystem = system
    }
    
    func addTodo(_ title: String) {
        cacheSystem.save(todo: Todo(title: title))
    }
    
    func listTodos() {
        if (cacheSystem.todoList.isEmpty) {
            print("Empty Todo list")
            return
        }
        if (cacheSystem.todoList.count == 1) {
            print("Your todo:")
        } else {
            print("Your todos:")
        }
        for (index, todo) in cacheSystem.todoList.enumerated() {
            print("\(index+1). \(todo)")
        }
    }
    
    func toggleCompletion(at index: Int) throws {
        if (index > cacheSystem.todoList.count || index < 1) {
            throw ListError.illigalIndex
        }
        cacheSystem.todoList[index-1].isCompleted.toggle()
    }
    
    func delete(at index: Int) throws {
        if (index > cacheSystem.todoList.count || index < 1) {
            throw ListError.illigalIndex
        }
        cacheSystem.todoList.remove(at: index-1)
    }
}
