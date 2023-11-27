//
//  Persistence.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-21.
//

import CoreData

struct CurrentData:Equatable, Hashable {
    var date: String
    var time: String
    var cloudCover: Int16
    var sunrise: String
    var sunset: String
    var isDay: Bool
    var temp: Int16
}
struct DayData: Equatable,Hashable  {
    var dayName: String
    var cloudCover: Int
    var rainProp: Int
    var temp: Int
}
struct HourData: Equatable ,Hashable {
    var time: String
    var cloudCover: Int
    var rainProp: Int
    var temp: Int
}

struct Location : Hashable{
    var name: String
    var currentData: CurrentData
    var hourData: [HourData]
    var dayData: [DayData]
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
    
    func createEntity(withData data: Location) async {
        print("Inside create entity")
        let context = container.newBackgroundContext()
        return await context.perform {
            let newEntity = LocationEntity(context: context)
        
            print("Map entity")
            newEntity.currentData = mapToCurrentDataEntity(data.currentData, context: context)
            newEntity.hourData = NSSet(array: data.hourData.map { mapToHourDataEntity($0, context: context) })
            newEntity.dayData = NSSet(array: data.dayData.map { mapToDayDataEntity($0, context: context) })
            newEntity.name = data.name
            do {
                try context.save()
                print("Created entity")
            } catch {
                print("Failed to create entity: \(error)")
            }
        }
    }

    
    
    func loadEntities() async -> [Location] {
        let context = container.newBackgroundContext()
        return await context.perform{
            let fetchRequest: NSFetchRequest<LocationEntity> = LocationEntity.fetchRequest()

            do {
                let entities = try context.fetch(fetchRequest)
                return entities.map { mapToLocation($0) }
            } catch {
                print("Failed to fetch entities: \(error)")
                return []
            }
            
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
    private func mapToCurrentDataEntity(_ data: CurrentData, context: NSManagedObjectContext) -> CurrentDataEntity {
        let entity = CurrentDataEntity(context: context)
        entity.date = data.date
        entity.time = data.time
        entity.sunrise = data.sunrise
        entity.sunset = data.sunset
        entity.isDay = data.isDay
        entity.cloudCover = data.cloudCover
        entity.temp = data.temp
        return entity
    }

    private func mapToHourDataEntity(_ data: HourData, context: NSManagedObjectContext) -> HourDataEntity {
        let entity = HourDataEntity(context: context)
        entity.time = data.time
        entity.cloudCover = Int16(data.cloudCover)
        entity.rainProp = Int16(data.rainProp)
        entity.temp = Int16(data.temp)
        return entity
    }

    private func mapToDayDataEntity(_ data: DayData, context: NSManagedObjectContext) -> DayDataEntity {
        let entity = DayDataEntity(context: context)
        entity.dayName = data.dayName
        entity.cloudCover = Int16(data.cloudCover)
        entity.rainProp = Int16(data.rainProp)
        entity.temp = Int16(data.temp)
        return entity
    }
    private func mapToLocationEntity(_ data: Location, context: NSManagedObjectContext) -> LocationEntity {
        let entity = LocationEntity(context: context)
        entity.name = data.name
        entity.currentData = mapToCurrentDataEntity(data.currentData, context:context)
        
        let dayDataEntities = data.dayData.map { mapToDayDataEntity($0, context: context) }
        entity.dayData = NSSet(array: dayDataEntities)

        let hourDataEntities = data.hourData.map { mapToHourDataEntity($0, context: context) }
        entity.hourData = NSSet(array: hourDataEntities)
        
        return entity
    }
    
    
    
    private func mapToLocation(_ entity: LocationEntity) -> Location {
        let currentData = CurrentData(
            date: entity.currentData?.date ?? "",
            time: entity.currentData?.time ?? "",
            cloudCover: entity.currentData?.cloudCover ?? 0,
            sunrise: entity.currentData?.sunrise ?? "",
            sunset: entity.currentData?.sunset ?? "",
            isDay: entity.currentData?.isDay ?? true,
            temp: entity.currentData?.temp ?? 0
        )

        let hourData = (entity.hourData as? Set<HourDataEntity>)?.map { hourEntity in
            HourData(
                time: hourEntity.time ?? "",
                cloudCover: Int(hourEntity.cloudCover),
                rainProp: Int(hourEntity.rainProp),
                temp: Int(hourEntity.temp)
            )
        } ?? []

        let dayData = (entity.dayData as? Set<DayDataEntity>)?.map { dayEntity in
            DayData(
                dayName: dayEntity.dayName ?? "",
                cloudCover: Int(dayEntity.cloudCover),
                rainProp: Int(dayEntity.rainProp),
                temp: Int(dayEntity.temp)
            )
        } ?? []

        let location = Location(name: entity.name ?? "", currentData: currentData, hourData: hourData, dayData: dayData)
        return location
    }


}
