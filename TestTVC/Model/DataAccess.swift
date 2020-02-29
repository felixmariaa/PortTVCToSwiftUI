//
//  Department.swift
//  TestTVC
//
//  Created by Felix Marianayagam on 2/29/20.
//  Copyright © 2020 SubhaFelix. All rights reserved.
//

import UIKit
import CoreData

protocol DataAccess {
}

extension DataAccess {
    func getDepartmentsFRC(viewContext: NSManagedObjectContext, deleteCache: Bool = false) -> NSFetchedResultsController<Department> {
        let cacheName: String? = "Department"
        if deleteCache {
            NSFetchedResultsController<Department>.deleteCache(withName: cacheName)
        }
        let request = NSFetchRequest<Department>(entityName: "Department")
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSort]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: cacheName)
        frc.fetchRequest.fetchBatchSize = 20
        
        do {
            try frc.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        return frc
    }
    
    func addSampleDepartments(viewContext: NSManagedObjectContext) {
        // Add a few sample departments
        let departments = ["Purchase", "Support", "Technical", "Marketing", "Promo", "Sales"]
        for department in departments {
            let dept = Department.init(context: viewContext)
            dept.name = department
        }
        DispatchQueue.main.async {
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
}
