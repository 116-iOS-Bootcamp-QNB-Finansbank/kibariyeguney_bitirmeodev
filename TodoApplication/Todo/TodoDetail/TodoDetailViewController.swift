//
//  TodoDetailViewController.swift
//  TodoApplication
//
//  Created by Kibariye on 12.10.2021.
//

import UIKit

class TodoDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var todoName: UITextField!
    @IBOutlet weak var todoDetail: UITextField!
    @IBOutlet weak var todoEndTime: UIDatePicker!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var todo : TodoListEntity?
    
    var update : (()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        if todo != nil {
         
            todoName.text = todo?.name
            todoDetail.text = todo?.detail
            todoEndTime.date = (todo?.finishTime)!
        
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: todoEndTime.date)
            let yourDate = formatter.date(from: myString)
            todo?.finishTime = yourDate
        }
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let todoNameText = todoName.text, !todoNameText.isEmpty else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        let context = persistantContainer.viewContext
        
        if todo == nil {
            todo = TodoListEntity(context: context)
            todo!.uuid = UUID()
        }
        
        todo!.name = todoNameText
        todo?.detail = todoDetail.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: todoEndTime.date)
        let yourDate = formatter.date(from: myString)
        todo?.finishTime = yourDate
         
        appDelegate.saveContext()
            
        update?()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if todo == nil {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        let context = persistantContainer.viewContext
        
        context.delete(todo!)

        // To delete the entity from the persistent store, call
        // save on the context
        do {
            try context.save()
        }
        catch {
            // Handle Error
        }
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }
}
