//
//  Player.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

final class Player {
    // MARK: Properties
    var number: Int
    var name = ""
    var team: [Character] = []
    private enum JobType {
        case mercenary, arbalester, pyromaniac, magus
    }
    
    init(number: Int) {
        self.number = number
        print("\nChoose a name for Player \(number):")
        if let name = readLine() {
            self.name = name
        }
    }
    
    func selectCharacters() {
        print("""
            \n\(name), you can now choose 3 characters for your team.
            (1 = mercenary, 2 = arbalester, 3 = pyromaniac, 4 = magus)
            """)
        while team.count < 3 { // Until there are three characters
            print("Select a new character:")
            var jobType: JobType?
            if let choice = readLine() { // Deals with the choice entered by the player
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
                if let jobType = jobType, let character = createCharacter(job: jobType) { // Creates a character with the job selected by the player
                    team.append(character) // Adds new character to the player's team
                }
            }
        }
    }
    
    private func createCharacter(job: JobType) -> Character? {
        print("Choose a name for your \(job):")
        if let newName = readLine() { // Lets the player choose a name for his character
            for existingName in Game.existingCharacterNames {
                if newName == existingName { // Compares the new name with every existing name, and goes back to the previous logic without creating a character if there's a match
                    print("This name was already chosen. Please pick another one.")
                    return nil
                }
            }
            if newName.count < 3 { // Goes back to the previous logic if the chosen name contains less than 3 characters
                print("The name must have at least 3 characters. Please try again.")
                return nil
            }
            switch job { // Creates an instance of the chosen Character subclass
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
        return nil // (in case the player doesn't enter a valid input)
    }
    
    func showStats() {
        print("-> \(name.uppercased())'S TEAM:")
        for character in team {
            character.stats() // Prints the every character's stats
        }
    }
    
    func teamIsDead() -> Bool {
        if team[0].isDead && team[1].isDead && team[2].isDead {
            return true
        } else {
            return false // Returns true if every character in the team is dead, false if not
        }
    }
    
    func manageChest() {
        let randomIndex = Int.random(in: 0...2) // Creates a random index between 0, 1 and 2
        if !team[randomIndex].isDead { // Performs the following logic if the character at the random index isn't dead
            print("""
                A chest magically appears in front of \(team[randomIndex].name)!
                Would you like to open it and swap \(team[randomIndex].name)'s \(team[randomIndex].weapon.name) for the weapon that's hidden inside? (Y/N)
                """)
            if let answer = readLine() {
                switch answer.lowercased() {
                case "y":
                    team[randomIndex].swapWeapons()
                case "n":
                    print("\(team[randomIndex].name) doesn't open the chest. The battle continues!")
                default:
                    print("Invalid input. The battle continues...")
                }
            }
        }
    }
    
    func selectAlly() -> Character? {
        var allies: [Character] = [] // Creates an empty array of allies
        for character in team {
            if !character.isDead {
                allies.append(character) // Appends every character that isn't dead
            }
        }
        var listOfRemainingAllies = ""
        for i in 0...allies.count - 1 {
            listOfRemainingAllies += "\(i+1) = \(allies[i].name)  " // Creates a list with all remaining allies
        }
        print("""
            Select one of your allies for the next action:
            \(listOfRemainingAllies)
            """)
        guard let choice = readLine() else { // Asks for the player's choice
            return nil
        }
        if Int(choice)! > 0 && Int(choice)! <= allies.count {
            return allies[Int(choice)! - 1] // If the choice is more than 0 and maximum the last number in the list of allies, returns the selected character
        } else {
            print("Invalid input. Next player's turn.")
            return nil // Otherwise, goes back to the previous logic witout returning anything
        }
    }
    
    func selectEnemy(amongst players: [Player]) -> Character? {
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
