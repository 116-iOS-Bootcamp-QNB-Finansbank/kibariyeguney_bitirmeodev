//
//  TodoListViewController.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import UIKit

let myNotificationKey = "todoListChanged"

class TodoListViewController: UIViewController, UISearchBarDelegate, TodoListViewProtocol{
        
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var orderTodoButton: UIBarButtonItem!
    @IBOutlet weak var addTodoNameButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        searchBar.delegate = self
        
        presenter.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                                    selector: #selector(doAfterNotified),
                                                    name: NSNotification.Name(rawValue: myNotificationKey),
                                                    object: nil)
    }

    @objc func doAfterNotified() {
        self.presenter.viewDidLoad()
   }
        
    var presenter: TodoListPresenterProtocol!
    var todoLists: [TodoListPresentation] = []
    var filteredTodoLists: [TodoListPresentation] = []

    func handleOutput(_ output: TodoListPresenterOutput) {
        switch output {
        case .showTodoList(let todoLists):
            self.todoLists = todoLists
            filteredTodoLists = todoLists
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateTodoList() {
        self.presenter.viewDidLoad()
    }
    
    @IBAction func addTodoButtonTapped(_ sender: Any) {
        presenter.addRow()
        presenter.viewDidLoad()
    }
    
    
    @IBAction func orderTodoButtonTapped(_ sender: Any) {
        for item in filteredTodoLists {
            print(item.date)
        }
        filteredTodoLists.sort(by: { $0.date < $1.date })
        
        self.tableView.reloadData()
    }
}

    extension TodoListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let indexPath2 : IndexPath = IndexPath(row: filteredTodoLists[indexPath.row].index, section: 0)
            presenter.didSelectRow(at: indexPath2)
            
        }
        
    }

    extension TodoListViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredTodoLists.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)
            cell.textLabel?.text = filteredTodoLists[indexPath.row].title
            return cell
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filteredTodoLists = []
            if (searchText == ""){
                filteredTodoLists = todoLists
            } else {
                for todo in todoLists {
                    if (todo.title.lowercased().contains(searchText.lowercased())){
                        filteredTodoLists.append(todo)
                    }
                }
            }
            self.tableView.reloadData()
        }
        
    }

