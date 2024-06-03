//
//  NOTIFICATION+CoreDataProperties.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2023. 03. 10..
//
//

import Foundation
import CoreData


extension NOTIFICATION {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NOTIFICATION> {
        return NSFetchRequest<NOTIFICATION>(entityName: "NOTIFICATION")
    }

    @NSManaged public var ison: Bool
    @NSManaged public var notificationindex: String?
    @NSManaged public var time: Int
    @NSManaged public var title: String?
    @NSManaged public var type: Int

}

extension NOTIFICATION : Identifiable {

}
