//
//  CoreDataManager.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 06.11.2023.
//

//import Foundation
//import CoreData
//
//class CoreDataManager{
//    var persistentContainer: NSPersistentContainer
//
//    init(){
//        persistentContainer = NSPersistentContainer(name: "Repositories")
//        persistentContainer.loadPersistentStores{ (description, error) in
//            if let error = error {
//                fatalError("Core Data failed to \(error.localizedDescription)")
//            }
//        }
//    }
//    func saveRepo(id: Int){
//        let context = persistentContainer.viewContext
//        let repo = Repositories(context: context)
//        repo.id = Int32(id)
//        do{
//           try persistentContainer.viewContext.save()
//        }catch{
//            print("Fail")
//        }
//
//    }
//    func saveUser(id: Int){
//        let context = persistentContainer.viewContext
//        let repo = User_repo(context: context)
//        repo.id = Int32(id)
//        do{
//           try persistentContainer.viewContext.save()
//        }catch{
//            print("Fail")
//        }
//    }
//    func getAllUser(){
//        let context = persistentContainer.viewContext
//        let repo = User_repo(context: context)
//        repo.id = Int32(id)
//        do{
//           try persistentContainer.viewContext.save()
//        }catch{
//            print("Fail")
//        }
//    }
//
//    func getAllRepos() -> [Repositories] {
//            let context = persistentContainer.viewContext
//            let fetchRequest: NSFetchRequest<Repositories> = Repositories.fetchRequest()
//
//            do {
//                return try context.fetch(fetchRequest)
//            } catch {
//                print("Failed to fetch repositories from Core Data: \(error.localizedDescription)")
//                return []
//            }
//        }
//}
