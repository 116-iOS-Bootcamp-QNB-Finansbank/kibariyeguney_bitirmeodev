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
        
        if todo == nil {
            CoreDataService.instance.addTodo(todoDetailPresentation:todoDetailPresentation)
        } else {
            CoreDataService.instance.updateTodo(todoDetailPresentation:todoDetailPresentation, todo:todo!)
        }
    }
    
    
    func fieldChanged (todoName:String, todoDetail:String, todoEndTime:Date)->Bool{
        if (todoName != todo?.name){
            return true;
        }
        if (todoDetail != todo?.detail){
            return true;
        }
        if (todoEndTime != todo?.finishTime){
            return true;
        }
        return false
    }
    
    func isEmpty() -> Bool{
        return todo == nil
    }
    
    func deleteTodo() {
         
        if todo == nil {
            return
        }
        CoreDataService.instance.deleteTodo(todo: todo!)
    }
}
