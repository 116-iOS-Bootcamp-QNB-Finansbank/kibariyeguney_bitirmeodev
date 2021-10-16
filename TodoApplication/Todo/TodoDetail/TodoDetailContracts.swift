//
//  TodoDetailContracts.swift
//  TodoApplication
//
//  Created by Kibariye on 14.10.2021.
//

import Foundation
protocol TodoDetailViewModelDelegate: NSObject {
    func showTodoDetail(_ todo: TodoDetailPresentation)
}

protocol TodoDetailViewModelProtocol {
    var delegate: TodoDetailViewModelDelegate? { get set }
    func viewDidLoad()
    func saveTodo(todoDetailPresentation : TodoDetailPresentation)
    func deleteTodo()
    func isEmpty() -> Bool
}
