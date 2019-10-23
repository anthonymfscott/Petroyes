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
        didSet { // Selects a case of WeaponComparison according to the comparison between the old and the new value
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
    private var weaponComparison: WeaponComparison
    
    private enum WeaponComparison {
        case same, better, worse
        var exclamation: String {
            switch self {
            case .same:
                return "Nothing changes!"
            case .better:
                return "How lucky!"
            case .worse:
                return "Too bad!"
            }
        }
        var strengthDescription: String {
            switch self {
            case .same:
                return "the same"
            case .better:
                return "a stronger"
            case .worse:
                return "a weaker"
            }
        }
    }
    
    init(name: String) {
        if !name.isEmpty { // (if the name isn't empty)
            self.name = name
            Game.existingCharacterNames.append(name) // Appends the name to the existing character names' array
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
    
    func takeAction(targetCharacter: Character) {
        print("\(name) hits \(targetCharacter.name)!")
        targetCharacter.hp -= weapon.actionPoints // Takes away the according number of health points
        print("\(targetCharacter.name) loses \(weapon.actionPoints) health points!")
        if targetCharacter.hp <= 0 {
            targetCharacter.hp = 0
            targetCharacter.isDead = true
            print("\(targetCharacter.name) is dead!") // Sets the statistics if the target character is killed
        }
    }
    
    func swapWeapons() {
        let randomNumber = Int.random(in: 0...2) // Selects a random number between 0, 1 and 2
        switch randomNumber { // Selects a weapon in the available weapons' array according to the random number
        case 0:
            weapon = availableWeapons[0]
        case 1:
            weapon = availableWeapons[1]
        default:
            weapon = availableWeapons[2]
        }
        print("\(weaponComparison.exclamation) \(name) opens the chest and gets \(weaponComparison.strengthDescription) weapon: \(weapon.name.uppercased()) (action points: \(weapon.actionPoints)).")
    }
}
