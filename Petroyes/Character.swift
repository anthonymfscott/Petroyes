//
//  Character.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

public class Character {
    var name = ""
    var job = ""
    var hp = 0
    internal var availableWeapons: [Weapon] = []
    var weapon = Weapon(name: "", actionPoints: 0)
    internal var description = ""
    var isDead = false
    
    init(name: String) {
        if !name.isEmpty {
            self.name = name
            Game.existingCharacterNames.append(name)
        }
    }
    
    func describe() {
        print("""
            - \(job.uppercased())
                \(description)
                health points: \(hp)
                weapon: \(weapon.name)
                action points: \(weapon.actionPoints)
            """)
    }
    
    func stats() {
        print("     \(name) (\(weapon.name)): \(hp) hp")
    }
    
    func action(targetCharacter: Character) {
        print("\(name) hits \(targetCharacter.name)!")
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
