//
//  Character.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

class Character {
    var name = ""
    var job = ""
    var hp = 0
    var availableWeapons: [Weapon] = []
    var weapon = Weapon(name: "", actionPoints: 0)
    var description = ""
    var isDead = false
    
    init(name: String) {
        if !name.isEmpty {
            self.name = name
            Game.existingCharacterNames.append(name)
        }
    }
    
    func describeJob() {
        print("""
            - \(job.uppercased())
                \(description)
                health points: \(hp)
                weapon: \(weapon.name)
                action points: \(weapon.actionPoints)
            """)
    }
    
    func shortlyDescribe() {
        print("     \(name), \(job)")
    }
    
    func stats() {
        print("     \(name) (\(weapon.name)): \(hp) hp")
    }
    
    func action(targetCharacter: Character) {
        print("\(name) hits \(targetCharacter.name)")
        targetCharacter.hp -= weapon.actionPoints
        print("\(targetCharacter.name) loses \(weapon.actionPoints) health points!")
        if targetCharacter.hp <= 0 {
            targetCharacter.hp = 0
            targetCharacter.isDead = true
            print("\(targetCharacter.name) is dead!")
        }
    }
    
    func swapsWeapon() -> String {
        let randomNumber = Int.random(in: 0...2)
        switch randomNumber {
        case 0:
            weapon = availableWeapons[0]
            return "\(name) opens the chest and gets a standard weapon: \(weapon.name.uppercased()) (action points: \(weapon.actionPoints))."
        case 1:
            weapon = availableWeapons[1]
            return "Too bad! \(name) opens the chest and gets a weak weapon: \(weapon.name.uppercased()) (action points: \(weapon.actionPoints))."
        case 2:
            weapon = availableWeapons[2]
            return "How lucky! \(name) opens the chest and gets a strong weapon: \(weapon.name.uppercased()) (action points: \(weapon.actionPoints))."
        default:
            return "Nothing happens."
        }
    }
}

// MARK: Subclasses
class Mercenary: Character {
    override init(name: String = "") {
        super.init(name: name)
        job = "mercenary"
        hp = 100
        availableWeapons = [sword, dagger, axe]
        weapon = availableWeapons[0]
        description = "Mercenaries are very tough, experts at close-range fighting using all types of swords."
    }
}

class Arbalester: Character {
    override init(name: String = ""){
        super.init(name: name)
        job = "arbalester"
        hp = 90
        availableWeapons = [crossbow, darts, superarbalest]
        weapon = availableWeapons[0]
        description = "Arbalesters use their crossbows to shoot powerful bolts from a distance."
    }
}

class Pyromaniac: Character {
    override init(name: String = "") {
        super.init(name: name)
        job = "pyromaniac"
        hp = 80
        availableWeapons = [blowtorch, matchbox, flamethrower]
        weapon = availableWeapons[0]
        description = "Pyromaniacs love throwing devastating fire at their enemies... but are less resistant than their peers."
    }
}

class Magus: Character {
    override init(name: String = "") {
        super.init(name: name)
        job = "magus"
        hp = 70
        availableWeapons = [wand, foofoodust, magicstaff]
        weapon = availableWeapons[0]
        description = "Magi don't take part in the fight, but excel at healing wounds using the power of their wands."
    }
    
    override func action(targetCharacter: Character) {
        print("\(name) cures \(targetCharacter.name)")
        targetCharacter.hp += weapon.actionPoints
        print("\(targetCharacter.name) recovers \(weapon.actionPoints) health points!")
    }
}
