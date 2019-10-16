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
    var weapon = Weapon(name: "", actionPoints: 0) {
        didSet {
            if oldValue.actionPoints < weapon.actionPoints {
                weaponComparison = .better
            } else if oldValue.actionPoints > weapon.actionPoints {
                weaponComparison = .worse
            } else {
                weaponComparison = .same
            }
        }
    }
    var description = ""
    var isDead = false
    private enum WeaponComparison {
        case same, better, worse
    }
    private var weaponComparison: WeaponComparison
    
    init(name: String) {
        if !name.isEmpty {
            self.name = name
            Game.existingCharacterNames.append(name)
        }
        weaponComparison = .same
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
    
    func swapsWeapon() {
        let randomNumber = Int.random(in: 0...2)
        switch randomNumber {
        case 0:
            weapon = availableWeapons[0]
        case 1:
            weapon = availableWeapons[1]
        default:
            weapon = availableWeapons[2]
        }
        switch weaponComparison {
        case .better:
            print("How lucky! \(name) opens the chest and gets a stronger weapon: \(weapon.name.uppercased()) (action points: \(weapon.actionPoints)).")
        case .worse:
            print("Too bad! \(name) opens the chest and gets a weaker weapon: \(weapon.name.uppercased()) (action points: \(weapon.actionPoints)).")
        case .same:
            print("Nothing changes! \(name) opens the chest and finds the same weapon: \(weapon.name.uppercased()) (action points: \(weapon.actionPoints)).")
        }
    }
}
