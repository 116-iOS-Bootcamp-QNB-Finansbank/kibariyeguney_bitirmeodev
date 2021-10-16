//
//  TodoListInteractor.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import UIKit
import Foundation

class TodoListInteractor: NSObject, TodoListInteractorProtocol {
    weak var delegate: TodoListInteractorDelegate?
    private let service: CoreDataService
    private var todoLists: [TodoListEntity] = []
    
    init(service: CoreDataService) {
        self.service = service
    }
    
    func viewDidLoad() {
        // send screen name event
        getTodoList()
    }
    
    func getTodoList() {
        let results: [TodoListEntity] = service.getTodoList()
        self.todoLists = results
        self.delegate?.handleOutput(.showTodoList(results))
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let todo = todoLists[indexPath.row]
        self.delegate?.handleOutput(.showTodoDetail(todo))
    }
    
    func addRow() {
        //let todo = TodoListEntity()
        self.delegate?.handleOutput(.showTodoDetailEmpty)
    }
}
