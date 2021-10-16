//
//  CoreDataService.swift
//  TodoApplication
//
//  Created by Kibariye on 15.10.2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {
    
    static let instance = CoreDataService()
    
    func getContext()-> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        let context = persistantContainer.viewContext
        
        return context
    }
}
