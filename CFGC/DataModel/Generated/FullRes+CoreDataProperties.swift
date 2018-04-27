//
//  FullRes+CoreDataProperties.swift
//  CFGC
//
//  Created by Cory on 4/26/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//
//

import Foundation
import CoreData


extension FullRes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FullRes> {
        return NSFetchRequest<FullRes>(entityName: "FullRes")
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var thumbnail: Thumbnail?

}
