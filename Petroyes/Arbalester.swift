//
//  Arbalester.swift
//  Petroyes
//
//  Created by anthonymfscott on 16/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

final class Arbalester: Character {
    private let crossbow = Weapon(name: "crossbow", actionPoints: 20)
    private let darts = Weapon(name: "darts", actionPoints: 10)
    private let superarbalest = Weapon(name: "superarbalest", actionPoints: 40)
    
    override init(name: String = "") {
        super.init(name: name)
        job = "arbalester"
        hp = 90
        availableWeapons = [crossbow, darts, superarbalest]
        weapon = availableWeapons[0]
        description = "Arbalesters use their crossbows to shoot powerful bolts from a distance."
    }
}
