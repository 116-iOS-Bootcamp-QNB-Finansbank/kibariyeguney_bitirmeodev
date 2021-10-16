//
//  TodoListPresentation.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import Foundation

struct TodoListPresentation {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    init(todo: TodoListEntity) {
        self.init(title: todo.name!)
    }
}
