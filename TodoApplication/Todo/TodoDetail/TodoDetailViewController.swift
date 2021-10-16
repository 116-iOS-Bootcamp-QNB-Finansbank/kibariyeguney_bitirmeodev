//
//  TodoDetailViewController.swift
//  TodoApplication
//
//  Created by Kibariye on 16.10.2021.
//

import UIKit

class TodoDetailViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var todoName: UITextField!
    @IBOutlet weak var todoDetail: UITextField!

    @IBOutlet weak var todoEndTime: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var todo : TodoListEntity?
    var update : (()->Void)?
    
    var viewModel: TodoDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (viewModel != nil){
            viewModel.viewDidLoad()
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        viewModel.deleteTodo()
        update?()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let todoNameText = todoName.text, !todoNameText.isEmpty else { return }
        guard let todoDetailText = todoDetail.text, !todoDetailText.isEmpty else { return }
        
        var todoDetailPresentation = TodoDetailPresentation(name: todoNameText, detail: todoDetailText, finishTime: todoEndTime.date)
        viewModel.saveTodo(todoDetailPresentation: todoDetailPresentation)
            
        update?()
        
        navigationController?.popViewController(animated: true)
    }
}

extension TodoDetailViewController: TodoDetailViewModelDelegate {
    
    func showTodoDetail(_ todo: TodoDetailPresentation) {
        todoName.text = todo.name
        todoDetail.text = todo.detail
        todoEndTime.date = todo.finishTime
    }
}
