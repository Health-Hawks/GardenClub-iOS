//
//  Thumbnail+CoreDataProperties.swift
//  CFGC
//
//  Created by Cory on 4/26/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//
//

import Foundation
import CoreData


extension Thumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thumbnail> {
        return NSFetchRequest<Thumbnail>(entityName: "Thumbnail")
    }

    @NSManaged public var id: String
    @NSManaged public var imageData: NSData?
    @NSManaged public var fullRes: FullRes?

}
