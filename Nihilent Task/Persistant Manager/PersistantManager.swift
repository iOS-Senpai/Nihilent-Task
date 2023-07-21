//
//  PersistantManager.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import CoreData

final class PersistantManager {
    
    static let shared = PersistantManager(container: NSPersistentContainer(name: "FavoriteProduct"))
    
    private let persistanceContainer: NSPersistentContainer
    
    private init(container: NSPersistentContainer) {
        self.persistanceContainer = container
        loadPersistentStores()
    }
    
    private func loadPersistentStores() {
        self.persistanceContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Couldn't load persistent store due to some technical \(error)")
            }
        }
    }
    
    func save(completion: @escaping CompletionClosure = { _ in }) {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func insert(object: NSManagedObject) {
        managedContext.insert(object)
        save()
    }
    
    func delete(object: NSManagedObject) {
        managedContext.delete(object)
        save()
    }
}

/**
This is a very thin layer of encapsulation for core data. This can be extended to build more complex structure via abstraction.
**/

extension PersistantManager {
    typealias CompletionClosure = (Error?) -> Void
    
    var managedContext: NSManagedObjectContext {
        return PersistantManager.shared.persistanceContainer.viewContext
    }
}
