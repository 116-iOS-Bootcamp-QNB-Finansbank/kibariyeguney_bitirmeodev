//
//  AppRouter.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//
import UIKit

class AppRouter {
    
    func start(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: TodoListBuilder.build())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.windowScene = scene
        return window
    }
}
