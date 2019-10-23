//
//  Magus.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 16/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

final class Magus: Character {
    private let wand = Weapon(name: "wand", actionPoints: 15)
    private let fooFooDust = Weapon(name: "foo-foo dust", actionPoints: 7)
    private let magicStaff = Weapon(name: "magic staff", actionPoints: 30)
    
    override init(name: String = "") {
        super.init(name: name)
        job = "magus"
        hp = 70
        availableWeapons = [wand, fooFooDust, magicStaff]
        weapon = availableWeapons[0]
        description = "Magi don't take part in the fight, but excel at healing wounds using the power of their wands."
    }
    
    override func takeAction(targetCharacter: Character) {
        if targetCharacter.name != name {
            print("\(name) cures \(targetCharacter.name)!")
        }
        targetCharacter.hp += weapon.actionPoints
        print("\(targetCharacter.name) recovers \(weapon.actionPoints) health points!")
    }
}
