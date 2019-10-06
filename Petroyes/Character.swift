//
//  Character.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

class Character {
    var name: String?
    var job = ""
    var hp = 0
    var weapon = ""
    var strength = [String: Int]()
    var description = ""
    
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
            + "\nweapon: \(weapon)"
            + "\nstrength: \(strength["usual"]!)")
        if Game.existingCharacterNames.count == 0 {
            print(description)
        }
    }
    
    func action(targetCharacter: Character) {
        print("\(name!) hits \(targetCharacter.name!)!")
        targetCharacter.hp -= strength["usual"]!
        print("\(targetCharacter.name!) has lost \(strength["usual"]!) health points!")
    }
}

// MARK: Subclasses
class Mercenary: Character {
    override init(name: String?) {
        super.init(name: name)
        job = "mercenary"
        hp = 100
        weapon = "sword"
        strength = ["diminished": 5, "usual": 10, "increased": 20]
        description = "Mercenaries are very tough, and best at close-range fighting using all types of swords."
    }
}

class Arbalester: Character {
    override init(name: String?){
        super.init(name: name)
        job = "arbalester"
        hp = 90
        weapon = "crossbow"
        strength = ["diminished": 5, "usual": 12, "increased": 20]
        description = "Arbalesters use their crossbows to shoot powerful bolts from a distance."
    }
}

class Pyromaniac: Character {
    override init(name: String?) {
        super.init(name: name)
        job = "pyromaniac"
        hp = 80
        weapon = "blowtorch"
        strength = ["diminished": 5, "usual": 15, "increased": 20]
        description = "Pyromaniacs just love fire... maybe a little bit too much sometimes."
    }
}

class Magus: Character {
    override init(name: String?) {
        super.init(name: name)
        job = "magus"
        hp = 70
        weapon = "staff"
        strength = ["diminished": 5, "usual": 10, "increased": 20]
        description = "Magi aren't very good at fighting, but excel at healing wounds using the power of their staffs."
    }
    
    override func action(targetCharacter: Character) {
        print("\(name!) cures \(targetCharacter.name!)!")
        targetCharacter.hp += strength["usual"]!
        print("\(targetCharacter.name!) has recovered \(strength["usual"]!) health points!")
    }
}
