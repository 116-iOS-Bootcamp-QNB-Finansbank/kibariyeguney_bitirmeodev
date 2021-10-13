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
        /*if (!UserDefaults().bool(forKey: "setup")){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }*/
    }
        
    var presenter: TodoListPresenterProtocol!
    var movies: [TodoListPresentation] = []
    var filteredMovies: [TodoListPresentation] = []

    func handleOutput(_ output: TodoListPresenterOutput) {
        switch output {
        case .showTodoList(let movies):
            self.movies = movies
            filteredMovies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateTodoList() {
        self.presenter.viewDidLoad()
    }
    
    @IBAction func addTodoButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "TodoList", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TodoDetailViewController") as! TodoDetailViewController
        vc.title = "New Todo"
        vc.update = {
            self.presenter.viewDidLoad()
        }
        navigationController?.pushViewController(vc, animated: true)
        print("Button tapped")
    }
}

    extension TodoListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            presenter.didSelectRow(at: indexPath)
        }
    }

    extension TodoListViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredMovies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)
            cell.textLabel?.text = filteredMovies[indexPath.row].title
            return cell
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filteredMovies = []
            if (searchText == ""){
                filteredMovies = movies
            } else {
                for movie in movies {
                    if (movie.title.lowercased().contains(searchText.lowercased())){
                        filteredMovies.append(movie)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }

