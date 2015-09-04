//
//  Institution.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/23/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import CoreData

@objc(Institution)

class Institution: NSManagedObject {

    @NSManaged var instName: String
    @NSManaged var info: String
    @NSManaged var period: String

}
