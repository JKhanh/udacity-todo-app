//
//  Todo.swift
//  udacity-todo-app
//
//  Created by Khanh on 29/8/24.
//

import Foundation

class Todo: CustomStringConvertible, Codable {
    var description: String {
        let completedString = if self.isCompleted {
            "\u{2705}"
        } else {
            "\u{274C}"
        }
        return "\(completedString) \(self.title)"
    }
    
    var id: UUID
    var title: String
    var isCompleted: Bool
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
    }
}
