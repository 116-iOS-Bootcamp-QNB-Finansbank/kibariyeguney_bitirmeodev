//
//  CoreDataService.swift
//  TodoApplication
//
//  Created by Kibariye on 15.10.2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {
    
    static let instance = CoreDataService()
    
    var context: NSManagedObjectContext

    init() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            context = appDelegate.persistentContainer.viewContext
        }
    
    private func saveContext() {
        do {
           try context.save()
        }
        catch {
        }
    }
    
    func getTodoList() -> [TodoListEntity] {
        
        let fetchRequest: NSFetchRequest<TodoListEntity> = TodoListEntity.fetchRequest()
        var results: [TodoListEntity] = []
        do {
            results = try context.fetch(fetchRequest)
        } catch {
            //handle error
        }
        
        return results
    }
    
    func addTodo(todoDetailPresentation: TodoDetailPresentation) {
         
        let todo : TodoListEntity = TodoListEntity(context: context)
        todo.uuid = UUID()
        todo.name = todoDetailPresentation.name
        todo.detail = todoDetailPresentation.detail
        todo.finishTime = todoDetailPresentation.finishTime
         
        saveContext()
    }
    
    func updateTodo(todoDetailPresentation: TodoDetailPresentation, todo : TodoListEntity) {
        
        todo.name = todoDetailPresentation.name
        todo.detail = todoDetailPresentation.detail
        todo.finishTime = todoDetailPresentation.finishTime
        
        saveContext()
    }
    
    func deleteTodo(todo : TodoListEntity) {
        
        do {
            context.delete(todo)
            try context.save()
        }
        catch {
            // Handle Error
        }
    }
}
