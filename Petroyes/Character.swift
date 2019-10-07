//
//  Character.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

class Character {
    var name: String?
    var job = ""
    var hp = 0
    var availableWeapons: [String: String] = [:]
    var currentWeapon = ""
    var weaponsStrength: [String: Int] = [:]
    var currentStrength = 0
    var description = ""
    var isDead = false
    
    init(name: String?) {
        if let name = name {
            self.name = name
            Game.existingCharacterNames.append(name)
        }
    }
    
    func describe() {
        if let name = name {
            print("\n\(name)", terminator: "")
        }
        print("\n--- \(job) ---"
            + "\nhealth points: \(hp)"
            + "\nweapon: \(currentWeapon)"
            + "\nstrength: \(currentStrength)")
        if Game.existingCharacterNames.count == 0 {
            print(description)
        }
    }
    
    func stats() {
        print("\(name!): \(hp) hp")
    }
    
    func action(targetCharacter: Character) {
        print("\(name!) hits \(targetCharacter.name!)!")
        targetCharacter.hp -= currentStrength
        print("\(targetCharacter.name!) loses \(currentStrength) health points!")
        if targetCharacter.hp <= 0 {
            targetCharacter.hp = 0
            targetCharacter.isDead = true
            print("\(targetCharacter.name!) is dead!")
        }
    }
    
    func swopsWeapon() -> String {
        currentWeapon = availableWeapons["diminished"]!
        currentStrength = weaponsStrength["diminished"]!
        return "Too bad! \(name!) opens the chest and gets a weaker weapon: \(currentWeapon), strength: \(currentStrength)!"
    }
}

// MARK: Subclasses
class Mercenary: Character {
    override init(name: String?) {
        super.init(name: name)
        job = "mercenary"
        hp = 100
        availableWeapons = ["diminished": "knife", "usual": "sword", "increased": "axe"]
        currentWeapon = availableWeapons["usual"]!
        weaponsStrength = ["diminished": 5, "usual": 10, "increased": 20]
        currentStrength = weaponsStrength["usual"]!
        description = "Mercenaries are very tough, and best at close-range fighting using all types of swords."
    }
}

class Arbalester: Character {
    override init(name: String?){
        super.init(name: name)
        job = "arbalester"
        hp = 90
        availableWeapons = ["diminished": "darts", "usual": "crossbow", "increased": "superarbalest"]
        currentWeapon = availableWeapons["usual"]!
        weaponsStrength = ["diminished": 5, "usual": 12, "increased": 20]
        currentStrength = weaponsStrength["usual"]!
        description = "Arbalesters use their crossbows to shoot powerful bolts from a distance."
    }
}

class Pyromaniac: Character {
    override init(name: String?) {
        super.init(name: name)
        job = "pyromaniac"
        hp = 80
        availableWeapons = ["diminished": "matchbox", "usual": "blowtorch", "increased": "flamethrower"]
        currentWeapon = availableWeapons["usual"]!
        weaponsStrength = ["diminished": 5, "usual": 15, "increased": 20]
        currentStrength = weaponsStrength["usual"]!
        description = "Pyromaniacs just love fire... maybe a little bit too much sometimes."
    }
}

class Magus: Character {
    override init(name: String?) {
        super.init(name: name)
        job = "magus"
        hp = 70
        availableWeapons = ["diminished": "foo-foo dust", "usual": "wand", "increased": "magic staff"]
        currentWeapon = availableWeapons["usual"]!
        weaponsStrength = ["diminished": 5, "usual": 10, "increased": 20]
        currentStrength = weaponsStrength["usual"]!
        description = "Magi aren't very good at fighting, but excel at healing wounds using the power of their wands."
    }
    
    override func action(targetCharacter: Character) {
        print("\(name!) cures \(targetCharacter.name!)!")
        targetCharacter.hp += currentStrength
        print("\(targetCharacter.name!) recovers \(currentStrength) health points!")
    }
}
