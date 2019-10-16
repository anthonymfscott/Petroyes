//
//  Player.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

public class Player {
    internal var number: Int
    internal var name = ""
    internal var team: [Character] = []
    enum JobType {
        case mercenary, arbalester, pyromaniac, magus
    }
    
    init(number: Int) {
        self.number = number
        print("\nChoose a name for Player \(number):")
        if let name = readLine() {
           self.name = name
        }
    }
    
    internal func selectCharacters() {
        print("""
            \n\(name), you can now choose 3 characters for your team.
            (1 = mercenary, 2 = arbalester, 3 = pyromaniac, 4 = magus)
            """)
        while team.count < 3 {
            print("Select a new character:") // Asks each player to select their team
            var jobType: JobType?
            if let choice = readLine() {
                switch choice {
                case "1":
                    jobType = .mercenary
                case "2":
                    jobType = .arbalester
                case "3":
                    jobType = .pyromaniac
                case "4":
                    jobType = .magus
                default:
                    jobType = nil
                    print("Invalid input. Please try again.")
                }
                if let jobType = jobType, let character = createCharacter(job: jobType) {
                    team.append(character)
                }
            }
        }
    }
    
    private func createCharacter(job: JobType) -> Character? {
        print("Choose a name for your \(job):")
        if let newName = readLine() {
            for existingName in Game.existingCharacterNames {
                if newName == existingName {
                    print("This name was already chosen. Please pick another one:")
                    return nil
                }
            }
            if newName.count < 3 {
                print("The name must have at least 3 characters. Please try again.")
                return nil
            }
            switch job {
            case .mercenary:
                return Mercenary(name: newName)
            case .arbalester:
                return Arbalester(name: newName)
            case .pyromaniac:
                return Pyromaniac(name: newName)
            case .magus:
                return Magus(name: newName)
            }
        }
        return nil
    }
    
    internal func showStats() {
        print("-> \(name.uppercased())'S TEAM:")
        for character in team {
            character.stats()
        }
    }
    
    internal func teamIsDead() -> Bool {
        if team[0].isDead && team[1].isDead && team[2].isDead {
            return true
        } else {
            return false
        }
    }
    
    internal func chest() {
        let randomIndex = Int.random(in: 0...2)
        if !team[randomIndex].isDead {
            print("""
                A chest magically appears in front of \(team[randomIndex].name)!
                Would you like to open it and swap \(team[randomIndex].name)'s \(team[randomIndex].weapon.name) for the weapon that's hidden inside? (Y/N)
                """)
            if let answer = readLine() {
                switch answer.lowercased() {
                case "y":
                    print(team[randomIndex].swapsWeapon())
                case "n":
                    print("\(team[randomIndex].name) doesn't open the chest. The battle continues!")
                default:
                    print("Invalid input. The battle continues...")
                }
            }
        }
    }
    
    internal func selectAlly() -> Character? {
        var allies: [Character] = []
        for character in team {
            if !character.isDead {
                allies.append(character)
            }
        }
        var listOfRemainingAllies = ""
        for i in 0...allies.count - 1 {
            listOfRemainingAllies += "\(i+1) = \(allies[i].name)  "
        }
        print("""
            Select one of your allies for the next action:
            \(listOfRemainingAllies)
            """)
        guard let choice = readLine() else {
            return nil
        }
        if Int(choice)! > 0 && Int(choice)! <= allies.count {
            return allies[Int(choice)! - 1]
        } else {
            print("Invalid input. Next player's turn.")
            return nil
        }
    }
    
    internal func selectEnemy(amongst players: [Player]) -> Character? {
        var enemies: [Character] = []
        for player in players {
            if player !== self {
                for character in player.team {
                    if !character.isDead {
                        enemies.append(character)
                    }
                }
            }
        }
        var listOfRemainingEnemies = ""
        for enemyNumber in 0...enemies.count - 1 {
            listOfRemainingEnemies += "\(enemyNumber+1) = \(enemies[enemyNumber].name)  "
        }
        print("""
            Select an enemy for the next action:
            \(listOfRemainingEnemies)
            """)
        guard let choice = readLine() else {
            return nil
        }
        if Int(choice)! > 0 && Int(choice)! <= enemies.count {
            return enemies[Int(choice)! - 1]
        } else {
            print("Invalid input. Next player's turn.")
            return nil
        }
    }
}
