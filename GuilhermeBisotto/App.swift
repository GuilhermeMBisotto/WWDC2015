//
//  App.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/18/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import CoreData

@objc (App)

class App: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var appID: NSNumber
    @NSManaged var desc: String
    @NSManaged var videoType: String
    @NSManaged var appIcon: String
    @NSManaged var function: String


}
