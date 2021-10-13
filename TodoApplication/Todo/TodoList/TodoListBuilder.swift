//
//  TodoListBuilder.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import UIKit

class TodoListBuilder {
    static func build() -> TodoListViewController {
        let storyboard = UIStoryboard(name: "TodoList", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "TodoListViewController") as! TodoListViewController
        let interactor = TodoListInteractor(service: appContainer.service)
        let router = TodoListRouter(view: view)
        let presenter = TodoListPresenter(interactor: interactor, view: view, router: router)
        view.presenter = presenter
        interactor.delegate = presenter
        return view
    }
}
