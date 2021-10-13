//
//  ClientService.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import Foundation

protocol ClientNetworkServiceProtocol {
    func todoList(completion: @escaping (TodoDTO?, Error?) -> Void)
}

class ClientNetworkService: ClientNetworkServiceProtocol {
    private let moviesURLString = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json"
    
    private let networkService = NetworkService.instance
    
    func todoList(completion: @escaping (TodoDTO?, Error?) -> Void) {
        networkService.get(from: moviesURLString, completion: completion)
    }
}
