//
//  Mercenary.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 16/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

final class Mercenary: Character {
    private let sword = Weapon(name: "sword", actionPoints: 15)
    private let dagger = Weapon(name: "dagger", actionPoints: 7)
    private let axe = Weapon(name: "axe", actionPoints: 30)
    
    override init(name: String = "") {
        super.init(name: name)
        job = "mercenary"
        hp = 100
        availableWeapons = [sword, dagger, axe]
        weapon = availableWeapons[0]
        description = "Mercenaries are very tough, experts at close-range fighting using all types of swords."
    }
}
