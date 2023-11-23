//
//  Persistence.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-21.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer

    init() {
        
        container = NSPersistentContainer(name: "WatherForecast")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading from core data: \(error)")
            }
            else {
                print("Successfully loaded core data!")
            }
        }
    }
    
    func createEntity(withData data: Persistance){
        let context = container.viewContext
        let newEntity = PersistanceEntity(context: context)
    
        newEntity.text = data.text

        do {
            try context.save()
            print("Created entity")
        } catch {
            print("Failed to create entity: \(error)")
        }
    }
    
    func fetchEntities() -> [PersistanceEntity] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<PersistanceEntity> = PersistanceEntity.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch entities: \(error)")
            return []
        }
    }
    
    func updateEntity(entity: PersistanceEntity, withData data: Persistance) {
        entity.text = data.text
        
        do {
            try entity.managedObjectContext?.save()
        } catch {
            print("Failed to update entity: \(error)")
        }
    }
    
    func deleteEntity(entity: PersistanceEntity) {
        let context = container.viewContext
        context.delete(entity)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete entity: \(error)")
        }
    }

    
    func clearCoreDataStore() {
        guard let storeURL = container.persistentStoreDescriptions.first?.url else { return }

        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
            try container.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            print("Error clearing Core Data store: \(error)")
        }
    }
}
