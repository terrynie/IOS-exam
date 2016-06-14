//
//  ClassMate+CoreDataProperties.swift
//  CoreDataDemo2
//
//  Created by Terry on 16/6/14.
//  Copyright © 2016年 Terry. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ClassMate {

    @NSManaged var desc: String?
    @NSManaged var images: String?
    @NSManaged var name: String?
    @NSManaged var price: NSNumber?
    @NSManaged var grade: NSNumber?

}
