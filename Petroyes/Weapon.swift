//
//  Weapon.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 15/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

public class Weapon {
    var name: String
    var actionPoints: Int
    
    init(name: String, actionPoints: Int) {
        self.name = name
        self.actionPoints = actionPoints
    }
}

let sword = Weapon(name: "sword", actionPoints: 15)
let dagger = Weapon(name: "dagger", actionPoints: 7)
let axe = Weapon(name: "axe", actionPoints: 30)
let crossbow = Weapon(name: "crossbow", actionPoints: 20)
let darts = Weapon(name: "darts", actionPoints: 10)
let superarbalest = Weapon(name: "superarbalest", actionPoints: 40)
let blowtorch = Weapon(name: "blowtorch", actionPoints: 25)
let matchbox = Weapon(name: "matchbox", actionPoints: 12)
let flamethrower = Weapon(name: "flamethrower", actionPoints: 50)
let wand = Weapon(name: "wand", actionPoints: 15)
let foofoodust = Weapon(name: "foo-foo dust", actionPoints: 7)
let magicstaff = Weapon(name: "magic staff", actionPoints: 30)
