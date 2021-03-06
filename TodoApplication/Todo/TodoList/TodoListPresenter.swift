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
    var update : (()->Void)?
    
    private var interactor: TodoListInteractorProtocol {
        didSet {
            self.interactor.delegate = self
        }
    }
    
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
    func addRow() {
        interactor.addRow()
    }
}

extension TodoListPresenter: TodoListInteractorDelegate {
    func handleOutput(_ output: TodoListInteractorOutput) {
        switch output {
        case .showTodoList(let todoList):
            var presenterList: [TodoListPresentation] = []
            var i : Int = 0
            
            for todo in todoList {
                let p : TodoListPresentation = TodoListPresentation(todo: todo , index: i)
                
                presenterList.append(p)
                i = i+1
            }
            view.handleOutput(.showTodoList(presenterList))
        case .showTodoDetail(let todo):
            router.navigate(to: .showTodoDetail(todo))
        case .showTodoDetailEmpty:
            router.navigate(to: .showTodoDetailEmpty)
        }
    }
}
