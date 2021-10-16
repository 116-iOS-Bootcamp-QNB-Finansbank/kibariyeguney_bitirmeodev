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

    init() {
        
    }
    init(todo: TodoListEntity) {
        self.todo = todo
    }
    
    func viewDidLoad() {
        if(todo != nil){
            delegate?.showTodoDetail(TodoDetailPresentation(todo: todo!))
        }
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
    
    func isEmpty() -> Bool{
        return todo == nil
    }
    
    func deleteTodo() {
         
        if todo == nil {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        let context = persistantContainer.viewContext
        
        do {
            context.delete(todo!)
            try context.save()
        }
        catch {
            // Handle Error
        }
    }
}
