//
//  CustomB+CoreDataProperties.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2023. 03. 02..
//
//

import Foundation
import CoreData


extension CustomB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomB> {
        return NSFetchRequest<CustomB>(entityName: "CustomB")
    }

    @NSManaged public var quantity: Double
    @NSManaged public var type: String?
    @NSManaged public var measure: String?
    @NSManaged public var id: Int

}
