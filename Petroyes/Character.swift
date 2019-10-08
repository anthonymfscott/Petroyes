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
            print("\(name.uppercased())", terminator: "")
        }
        print("\n--- \(job) ---"
            + "\nhealth points: \(hp)"
            + "\ninitial weapon: \(currentWeapon)"
            + "\ninitial strength: \(currentStrength)")
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
    
    func swapsWeapon() -> String {
        let randomNumber = Int.random(in: 0...2)
        switch randomNumber {
        case 0:
            currentWeapon = availableWeapons["diminished"]!
            currentStrength = weaponsStrength["diminished"]!
            return "Too bad! \(name!) opens the chest and gets a weak weapon: \(currentWeapon.uppercased()) (strength: \(currentStrength))."
        case 1:
            currentWeapon = availableWeapons["usual"]!
            currentStrength = weaponsStrength["usual"]!
            return "\(name!) opens the chest and gets a standard weapon: \(currentWeapon.uppercased()) (strength: \(currentStrength))."
        case 2:
            currentWeapon = availableWeapons["increased"]!
            currentStrength = weaponsStrength["increased"]!
            return "How lucky! \(name!) opens the chest and gets a strong weapon: \(currentWeapon.uppercased()) (strength: \(currentStrength))."
        default:
            return "Nothing happens."
        }
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
        weaponsStrength = ["diminished": 10, "usual": 20, "increased": 40]
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
        weaponsStrength = ["diminished": 15, "usual": 30, "increased": 60]
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
        weaponsStrength = ["diminished": 20, "usual": 40, "increased": 80]
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
