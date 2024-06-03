//
//  Days+CoreDataProperties.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2023. 03. 10..
//
//

import Foundation
import CoreData


extension Days {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Days> {
        return NSFetchRequest<Days>(entityName: "Days")
    }

    @NSManaged public var consumption: Double
    @NSManaged public var day: Date?
    @NSManaged public var measure: Int
    @NSManaged public var note: NSSet?

}

// MARK: Generated accessors for note
extension Days {

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: Notes)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: Notes)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSSet)

}

extension Days : Identifiable {

}
