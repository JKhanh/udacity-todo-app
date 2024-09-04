//
//  App.swift
//  udacity-todo-app
//
//  Created by Khanh on 29/8/24.
//

import Foundation

class App {
    let todoManager = TodosManager()
    func run() {
        print("Welcome to Todo CLI")
        chooseCacheSystem()
        while true {
            print("What would you like to do? \(Command.listCommands()): ")
            guard let input = readLine()?.lowercased(), let command = Command(rawValue: input) else {
                print("Unknown command. Available commands: \(Command.listCommands())")
                continue
            }
            switch command {
            case .add:
                print("Enter todo title: ")
                guard let title = readLine() else {
                    print("Empty todo title")
                    continue
                }
                todoManager.addTodo(title)
                print("Todo added!")
                continue
            case .list:
                todoManager.listTodos()
                continue
            case .toggle:
                todoManager.listTodos()
                guard let index = readNumberFromKeyboard(message: "Enter the number of the todo to toggle: ") else {
                    continue
                }
                do {
                    try todoManager.toggleCompletion(at: index)
                    print("Todo completion status toggled")
                } catch {
                    print("Wrong number")
                }
                continue
            case .delete:
                todoManager.listTodos()
                guard let index = readNumberFromKeyboard(message: "Enter the number of the todo to delete: ") else {
                    continue
                }
                do {
                    try todoManager.delete(at: index)
                    print("Todo deleted!")
                } catch {
                    print("Wrong number")
                }
                continue
            case .exit:
                return
            }
        }
    }
    
    func chooseCacheSystem() {
        while true {
            print("Do you want to use and save your todos to file?")
            print("1. Yes. Use the todos.json file to load and save all mine todos.")
            print("2. No. I'll only need todos in this session.")
            guard let command = readNumberFromKeyboard(message: nil), command > 0, command < 3 else {
                print("Not a legal option. Please try again")
                continue
            }
            if (command == 1) {
                todoManager.setCacheSystem(system: FileSystemCache())
            }
            return
        }
    }
    
    func readNumberFromKeyboard(message: String?) -> Int? {
        if let message {
            print(message)
        }
        guard let indexString = readLine(), let index = Int(indexString) else {
            print("Iligal number")
            return nil
        }
        return index
    }
}

enum Command: String, CaseIterable {
    case add
    case list
    case toggle
    case delete
    case exit
    
    static func listCommands() -> String {
        return "(\(Command.allCases.map { $0.rawValue }.joined(separator: ", ")))"
    }
}
