//
//  TodoListRouter.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import UIKit

class TodoListRouter: NSObject, TodoListRouterProtocol {
    private unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: TodoListRoute) {
        switch route {
        case .showTodoDetail(let todo):
            let viewController = TodoDetailBuilder.build(with: todo)
            self.view.navigationController?.pushViewController(viewController, animated: true)
         
            /*let storyboard = UIStoryboard(name: "TodoList", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "TodoDetailViewController") as! TodoDetailViewController
            vc.title = "Change Todo"
            vc.todo = todo
            self.view.navigationController?.pushViewController(vc, animated: true)*/
        
        case .showTodoDetailEmpty:
            let viewController = TodoDetailBuilder.buildEmpty()
            self.view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
