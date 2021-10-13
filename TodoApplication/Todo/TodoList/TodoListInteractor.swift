//
//  TodoListInteractor.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import UIKit
import Foundation
import CoreData

class TodoListInteractor: NSObject, TodoListInteractorProtocol {
    weak var delegate: TodoListInteractorDelegate?
    private let service: ClientNetworkServiceProtocol
    private var todoLists: [TodoListEntity] = []
    
    init(service: ClientNetworkServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        // send screen name event
        getTodoList()
    }
    
    func getTodoList() {
        //service.todoList { [weak self] response, error in
            //guard let self = self else { return }
            //guard let results = response?.feed.results else { return }
            
            
            var results: [TodoListEntity] = []
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let persistantContainer = appDelegate.persistentContainer
                let context = persistantContainer.viewContext
                
                let fetchRequest: NSFetchRequest<TodoListEntity> = TodoListEntity.fetchRequest()
                do {
                    results = try context.fetch(fetchRequest)
                } catch {
                    //handle error
                }
            self.todoLists = results
            self.delegate?.handleOutput(.showTodoList(results))
            
        //}
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let todo = todoLists[indexPath.row]
        self.delegate?.handleOutput(.showTodoDetail(todo))
    }
}
