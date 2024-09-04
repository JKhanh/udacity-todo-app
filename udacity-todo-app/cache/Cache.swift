//
//  Cache.swift
//  udacity-todo-app
//
//  Created by Khanh on 30/8/24.
//

import Foundation

protocol Cache{
    var todoList: [Todo] {
        get
        set
    }
    
    func save(todo: Todo)
    func load() -> [Todo]
}
