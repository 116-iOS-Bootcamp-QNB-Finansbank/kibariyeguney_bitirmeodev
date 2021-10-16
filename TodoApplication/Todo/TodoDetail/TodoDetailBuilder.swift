//
//  TodoDetailBuilder.swift
//  TodoApplication
//
//  Created by Kibariye on 14.10.2021.
//

import Foundation
class TodoDetailBuilder {
    static func build(with todo: TodoListEntity) -> TodoDetailViewController {
        let viewController = TodoDetailViewController()
        viewController.viewModel = TodoDetailViewModel(todo: todo)
        return viewController
    }
    static func buildEmpty() -> TodoDetailViewController {
        let viewController = TodoDetailViewController()
        //viewController.viewModel = TodoDetailViewModel()
        return viewController
    }
}
