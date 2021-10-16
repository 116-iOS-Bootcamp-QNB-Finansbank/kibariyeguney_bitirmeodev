//
//  TodoDetailViewModel.swift
//  TodoApplication
//
//  Created by Kibariye on 14.10.2021.
//

import UIKit
import Foundation

class TodoDetailViewModel: TodoDetailViewModelProtocol {
    weak var delegate: TodoDetailViewModelDelegate?
    
    private var todo: TodoListEntity?

    init(todo: TodoListEntity) {
        self.todo = todo
    }
    
    func viewDidLoad() {
        delegate?.showTodoDetail(TodoDetailPresentation(todo: todo!))
    }
    
    func saveTodo(todoDetailPresentation : TodoDetailPresentation) {
         
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        let context = persistantContainer.viewContext
        
        if todo == nil {
            todo = TodoListEntity(context: context)
            todo!.uuid = UUID()
        }
        
        todo!.name = todoDetailPresentation.name
        todo!.detail = todoDetailPresentation.detail
        todo!.finishTime = todoDetailPresentation.finishTime
         
        appDelegate.saveContext()
    }
    
    func deleteTodo() {
         
        if todo == nil {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        let context = persistantContainer.viewContext
        
        context.delete(todo!)

        // To delete the entity from the persistent store, call
        // save on the context
        do {
            try context.save()
        }
        catch {
            // Handle Error
        }
    }
}
