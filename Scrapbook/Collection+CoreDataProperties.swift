//
//  Collection+CoreDataProperties.swift
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

extension Collection {

    @NSManaged var name: String?
    @NSManaged var own: NSSet?

}
