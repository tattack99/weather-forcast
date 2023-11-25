//
//  Persistence.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-21.
//

import CoreData

struct TemperatureViewData:Equatable, Hashable {
    var locationName: String
    var date: String
    var sunrise: String
    var sunset: String
}
struct DayItemData: Equatable,Hashable  {
    var day: String
    var image: String
    var temp: Double
}
struct HourItemData: Equatable ,Hashable {
    var time: String
    var image: String
    var temp: Double
}

struct FavoritLocation : Hashable{
    var tempData: TemperatureViewData
    var hourData: [HourItemData]
    var dayData: [DayItemData]
}

struct PersistenceController {
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Persistance")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading from core data: \(error)")
            }
            else {
                print("Successfully loaded core data!")
            }
        }
    }
    
    func createEntity(withData data: FavoritLocation) async {
        print("Inside create entity")
        let context = container.newBackgroundContext()
        return await context.perform {
            let newEntity = FavoritLocationEntity(context: context)
        
            print("Map entity")
            newEntity.tempData = mapTemperatureViewData(data.tempData, context: context)
            newEntity.hourData = NSSet(array: data.hourData.map { mapHourItemData($0, context: context) })
            newEntity.dayData = NSSet(array: data.dayData.map { mapDayItemData($0, context: context) })
            
            do {
                try context.save()
                print("Created entity")
            } catch {
                print("Failed to create entity: \(error)")
            }
        }
    }
    
    
    func loadEntities() async -> [FavoritLocation] {
        let context = container.newBackgroundContext()
        return await context.perform{
            let fetchRequest: NSFetchRequest<FavoritLocationEntity> = FavoritLocationEntity.fetchRequest()

            do {
                let entities = try context.fetch(fetchRequest)
                return entities.map { mapToFavoriteLocation($0) }
            } catch {
                print("Failed to fetch entities: \(error)")
                return []
            }
            
        }

    }
    
    /*
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
     */

    
    func clearCoreDataStore() {
        guard let storeURL = container.persistentStoreDescriptions.first?.url else { return }

        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
            try container.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            print("Error clearing Core Data store: \(error)")
        }
    }
    private func mapTemperatureViewData(_ data: TemperatureViewData, context: NSManagedObjectContext) -> TemperatureViewDataEntity {
        let entity = TemperatureViewDataEntity(context: context)
        entity.locationName = data.locationName
        entity.date = data.date
        entity.sunrise = data.sunrise
        entity.sunset = data.sunset
        return entity
    }

    private func mapHourItemData(_ data: HourItemData, context: NSManagedObjectContext) -> HourItemDataEntity {
        let entity = HourItemDataEntity(context: context)
        entity.time = data.time
        entity.image = data.image
        entity.temp = data.temp
        return entity
    }

    private func mapDayItemData(_ data: DayItemData, context: NSManagedObjectContext) -> DayItemDataEntity {
        let entity = DayItemDataEntity(context: context)
        entity.day = data.day
        entity.image = data.image
        entity.temp = data.temp
        return entity
    }
    
    private func mapToFavoriteLocation(_ entity: FavoritLocationEntity) -> FavoritLocation {
        let tempData = TemperatureViewData(
            locationName: entity.tempData?.locationName ?? "",
            date: entity.tempData?.date ?? "",
            sunrise: entity.tempData?.sunrise ?? "",
            sunset: entity.tempData?.sunset ?? ""
        )
        
        let hourData = (entity.hourData as? Set<HourItemDataEntity>)?.map { hourEntity in
            HourItemData(
                time: hourEntity.time ?? "",
                image: hourEntity.image ?? "",
                temp: hourEntity.temp
            )
        } ?? []
        
        let dayData = (entity.dayData as? Set<DayItemDataEntity>)?.map { dayEntity in
            DayItemData(
                day: dayEntity.day ?? "",
                image: dayEntity.image ?? "",
                temp: dayEntity.temp
            )
        } ?? []

        return FavoritLocation(tempData: tempData, hourData: hourData, dayData: dayData)
    }

}
