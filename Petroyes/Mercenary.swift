//
//  Mercenary.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 16/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

public class Mercenary: Character {
    override init(name: String = "") {
        super.init(name: name)
        job = "mercenary"
        hp = 100
        availableWeapons = [sword, dagger, axe]
        weapon = availableWeapons[0]
        description = "Mercenaries are very tough, experts at close-range fighting using all types of swords."
    }
}
