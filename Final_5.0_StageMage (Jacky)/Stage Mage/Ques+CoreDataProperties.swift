//
//  Ques+CoreDataProperties.swift
//  Stage Mage
//
//  Created by Jacky Liang on 2019-01-18.
//  Copyright © 2019 KingByngInc. All rights reserved.
//
//

import Foundation
import CoreData


extension Ques {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ques> {
        return NSFetchRequest<Ques>(entityName: "Ques")
    }

    @NSManaged public var name: String?
    @NSManaged public var details: String?

}
