//
//  Arbalester.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 16/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

public class Arbalester: Character {
    override init(name: String = ""){
        super.init(name: name)
        job = "arbalester"
        hp = 90
        availableWeapons = [crossbow, darts, superarbalest]
        weapon = availableWeapons[0]
        description = "Arbalesters use their crossbows to shoot powerful bolts from a distance."
    }
}
