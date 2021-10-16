//
//  TodoDetailPresentation.swift
//  TodoApplication
//
//  Created by Kibariye on 14.10.2021.
//

import Foundation

struct TodoDetailPresentation {
    var name: String
    var detail: String
    var finishTime: Date
    var uuid : UUID?
    
    init(name: String, detail: String, finishTime: Date) {
        self.name = name
        self.detail = detail
        self.finishTime = finishTime
    }
    
    init(name: String, detail: String, finishTime: Date, uuid: UUID) {
        self.name = name
        self.detail = detail
        self.finishTime = finishTime
        self.uuid = uuid
    }
    
    init(todo: TodoListEntity) {
        self.init(name: todo.name!,
                  detail: todo.detail!,
                  finishTime: todo.finishTime!,
                  uuid: todo.uuid ?? UUID())
    }
}
