//
//  TodoListViewController.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import UIKit

class TodoListViewController: UIViewController, UISearchBarDelegate, TodoListViewProtocol{
        
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var addTodoNameButton: UIBarButtonItem!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            searchBar.delegate = self
        
            presenter.viewDidLoad()
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
        
        /*let storyboard = UIStoryboard(name: "TodoList", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TodoDetailViewController") as! TodoDetailViewController
        vc.title = "New Todo"
        vc.update = {
            self.presenter.viewDidLoad()
        }
        navigationController?.pushViewController(vc, animated: true)
        print("Button tapped")*/
    }
}

    extension TodoListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            presenter.didSelectRow(at: indexPath)
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

