//
//  Clipping+CoreDataProperties.swift
//  Scrapbook
//
//  Created by SABai on 29/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Clipping {

    @NSManaged var note: String?
    @NSManaged var image: String?
    @NSManaged var dataCreated: NSDate?
    @NSManaged var belong: Collection?

}
