//
//  RealmDataStorage.swift
//  TVToday
//
//  Created by Jeans Ruiz on 7/2/20.
//  Copyright © 2020 Jeans. All rights reserved.
//

import Foundation
import RealmSwift

public final class RealmDataStorage {
  
  private let maxStorageLimit: Int
  
  private lazy var realm: Realm? = {
    do {
      let realm = try Realm()
      return realm
    } catch let error as NSError {
      return nil
    }
  }()
  
  public init(maxStorageLimit: Int) {
    self.maxStorageLimit = maxStorageLimit
    print(Realm.Configuration.defaultConfiguration.fileURL!)
  }
  
  // La propia entity debe asignarse sus variables
  // Acá debe llegar un EntityStorage
  public func saveEntitie(entitie: RealmShowVisited, completion: @escaping (() -> Void)) {
    guard let realm = realm else {
      completion()
      return
    }
    do {
      try realm.write {
        realm.add(entitie, update: .modified)
        toDeleted(retain: maxStorageLimit).forEach {
          print("Delete: \($0) OK")
          realm.delete($0)
        }
        print("Save: \(entitie) OK")
        
        completion()
      }
      
    } catch _ {
      completion()
    }
  }
  
  public func fetchAllOrdered(ascending: Bool = false) -> [RealmShowVisited] {
    guard let realm = realm else { return [] }
    return realm.objects(RealmShowVisited.self)
      .sorted(byKeyPath: "date", ascending: ascending).map { $0 }
  }
  
  private func toDeleted(retain keepElements: Int) -> [RealmShowVisited] {
    let allElements = fetchAllOrdered()
    let firstElements = fetchAllOrdered().prefix(keepElements)
    return allElements.filter { !firstElements.contains($0) }
  }
}