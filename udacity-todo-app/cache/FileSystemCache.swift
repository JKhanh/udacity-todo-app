//
//  FileSystemCache.swift
//  udacity-todo-app
//
//  Created by Khanh on 30/8/24.
//

import Foundation

class FileSystemCache: Cache {
    var todoList: [Todo] = []
    private var fileURI: URL
    
    init() {
        let currentDirectory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        fileURI = currentDirectory.appending(path: "todos.json")
        checkDataFileExistion()
        initData()
    }
    
    private func checkDataFileExistion() {
        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: fileURI.absoluteString)) {
            fileManager.createFile(atPath: fileURI.absoluteString, contents: nil)
        }
    }
    
    private func initData() {
        guard let data = try? Data(contentsOf: fileURI) else { return }
        todoList = (try? JSONDecoder().decode([Todo].self, from: data)) ?? []
    }
    
    func save(todo: Todo) {
        todoList.append(todo)
    }
    
    func load() -> [Todo] {
        todoList
    }
    
    private func saveToFile() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(todoList)
            try data.write(to: fileURI, options: [.atomic])
        } catch {
            print("Error saving file \(error.localizedDescription)")
        }
    }
    
    deinit {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(todoList)
            try data.write(to: fileURI, options: [.atomicWrite])
            print("Saved all todos to file.")
        } catch {
            print("Error saving todos: \(error.localizedDescription)")
        }
    }
}
