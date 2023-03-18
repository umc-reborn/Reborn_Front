//
//  Entity+CoreDataProperties.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/10.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16

}

extension Entity : Identifiable {

}
