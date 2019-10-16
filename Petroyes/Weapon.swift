//
//  Weapon.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 15/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

final class Weapon {
    var name: String
    var actionPoints: Int
    
    init(name: String, actionPoints: Int) {
        self.name = name
        self.actionPoints = actionPoints
    }
}
