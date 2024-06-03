//
//  Notes+CoreDataProperties.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2023. 03. 10..
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var drink: String?
    @NSManaged public var measure: Int
    @NSManaged public var quantity: Double
    @NSManaged public var day: Days?

}

extension Notes : Identifiable {

}
