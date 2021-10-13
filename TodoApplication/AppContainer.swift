//
//  AppContainer.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import Foundation

let appContainer = AppContainer()

class AppContainer {
    let service = ClientNetworkService()
    let router = AppRouter()
}
