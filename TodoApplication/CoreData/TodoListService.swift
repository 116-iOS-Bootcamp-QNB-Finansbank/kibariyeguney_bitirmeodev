//
//  TodoListService.swift
//  TodoApplication
//
//  Created by Kibariye on 15.10.2021.
//

import Foundation
import CoreData

protocol TodoListServiceProtocol {
    func getTodoList() ->  [TodoListEntity]
}

class TodoListService: TodoListServiceProtocol {
    private let coreDataService = CoreDataService.instance
    
    func getTodoList() -> [TodoListEntity] {
        
        let context = coreDataService.getContext()
        let fetchRequest: NSFetchRequest<TodoListEntity> = TodoListEntity.fetchRequest()
        var results: [TodoListEntity] = []
        do {
            results = try context.fetch(fetchRequest)
        } catch {
            //handle error
        }
        
        return results
    }
}
