//
//  Notification+CoreDataProperties.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2022. 12. 08..
//
//

import Foundation
import CoreData


extension Notification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notification> {
        return NSFetchRequest<Notification>(entityName: "Notification")
    }

    @NSManaged public var time: Int64
    @NSManaged public var isOn: Bool
    @NSManaged public var title: String?
    @NSManaged public var type: Int64

}

extension Notification : Identifiable {

}
