//
//  ManageCoreData.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 1.9.21..
//

import UIKit
import CoreData

class ManageCoreData{
    
    static func storeCity(city: Parent){

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CityEntity", in: managedContext)!
        let cityEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        
//        if let savedCity = retriveCity(){
//            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CityEntity")
//            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//            managedContext.delete(covertParentToNSManagedObject(city: savedCity)!)
//            do{
//                try managedContext.execute(deleteRequest)
//                try managedContext.save()
//            }catch let error as NSError{
//                print("Couldn't delete data, reason: \(error)")
//            }
//
//        }
        
        cityEntity.setValue(city.title, forKey: "title")
        cityEntity.setValue(city.locationType, forKey: "locationType")
        cityEntity.setValue(city.woeid, forKey: "woeid")
        cityEntity.setValue(city.lattLong, forKey: "lattLong")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Couldn't save data, reason: \(error)")
        }
    }
    
    static func retriveCity() -> Parent? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CityEntity")
        
        do{
            let cityList = try managedContext.fetch(fetchRequest)
            if cityList.count > 1{
                return covertNSManagedObjectToParent(object: cityList[0])
            }
        }catch let error as NSError{
            print("Couldn't retrive data, reason: \(error)")
        }
        
        return nil
    }
    
    static private func covertNSManagedObjectToParent(object: NSManagedObject) -> Parent?{
        print("ovo je object \(object)")
        return Parent(title: object.value(forKey: "title") as! String,
                      locationType: object.value(forKey: "locationType") as! String,
                      woeid: object.value(forKey: "woeid") as! Int,
                      lattLong: object.value(forKey: "lattLong") as! String)
    }
    
    static private func covertParentToNSManagedObject(city: Parent) -> NSManagedObject?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CityEntity", in: managedContext)!
        let cityEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        
        cityEntity.setValue(city.title, forKey: "title")
        cityEntity.setValue(city.locationType, forKey: "locationType")
        cityEntity.setValue(city.woeid, forKey: "woeid")
        cityEntity.setValue(city.lattLong, forKey: "lattLong")
        print(cityEntity, "ovo je cityEntity")
        return  cityEntity
    }
}
