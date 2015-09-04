//
//  Company.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/20/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import CoreData

@objc(Company)

class Company: NSManagedObject {

    @NSManaged var companyName: String
    @NSManaged var companyID: NSNumber
    @NSManaged var timeInCompany: String
    @NSManaged var function: String
    @NSManaged var desc: String

}
