//
//  TodoListPresenter.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import Foundation

class TodoListPresenter: NSObject, TodoListPresenterProtocol {
    private unowned let view: TodoListViewProtocol
    private let router: TodoListRouterProtocol
    private var interactor: TodoListInteractorProtocol
    
    init(interactor: TodoListInteractorProtocol,
         view: TodoListViewProtocol,
         router: TodoListRouterProtocol) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        interactor.didSelectRow(at: indexPath)
    }
}

extension TodoListPresenter: TodoListInteractorDelegate {
    func handleOutput(_ output: TodoListInteractorOutput) {
        switch output {
        case .showTodoList(let todoList):
            view.handleOutput(.showTodoList(todoList.map(TodoListPresentation.init)))
        case .showTodoDetail(let todo):
            router.navigate(to: .showTodoDetail(todo))
        }
    }
}
