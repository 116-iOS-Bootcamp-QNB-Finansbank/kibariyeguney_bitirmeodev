//
//  TodoListContracts.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import Foundation

//MARK: View
protocol TodoListViewProtocol: NSObject {
    func handleOutput(_ output: TodoListPresenterOutput)
}

//MARK: Interactor
enum TodoListInteractorOutput {
    case showTodoDetail(TodoListEntity)
    case showTodoList([TodoListEntity])
}

protocol TodoListInteractorDelegate: NSObject {
    func handleOutput(_ output: TodoListInteractorOutput)
}

protocol TodoListInteractorProtocol: NSObject {
    var delegate: TodoListInteractorDelegate? { get set }
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

//MARK: Presenter
protocol TodoListPresenterProtocol: NSObject {
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

enum TodoListPresenterOutput {
    case showTodoList([TodoListPresentation])
}

//MARK: Router
enum TodoListRoute {
    case showTodoDetail(TodoListEntity)
}

protocol TodoListRouterProtocol: NSObject {
    func navigate(to route: TodoListRoute)
}
