//
//  Game.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

class Game {
    // MARK: Properties
    // A series of properties that will be useful to the gameplay
    enum State {
        case ongoing, over
    }
    var numberOfPlayers: Int
    var players: [Player] = [] // An array containing the players
    var numberOfRounds: Int // Counts the number of rounds
    static var existingCharacterNames: [String] = [] // Stores the character names that were already created by other players and can't be used again
    enum JobType {
        case mercenary, arbalester, pyromaniac, magus
    }
    
    // MARK: Initialisation
    // A method that will be called each time a new game begins
    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
        numberOfRounds = 0 // Resets the number of rounds to 0
        print("\n\nWelcome to Petroyes.") // Prints a greeting for the players
        for i in 1...numberOfPlayers {
            let newPlayer = Player(number: Int(i))
            players.append(newPlayer)
        }
        print("\n\(players[0].name) and \(players[1].name) will have a fight today!") // Prints a catch phrase to arouse the players
        describeJobs() // Calls the so called method
        createTeams() // Calls the so called method
        fight()
    }
    
    // A method to create the players' teams of characters
    func createTeams() {
        for player in players { // A for-in that goes through the 'players' array
            print("\n\(player.name), you can now choose 3 characters for your team."
                + "\n(1 = Mercenary, 2 = Arbalester, 3 = Pyromaniac, 4 = Magus)")
            while player.team.count < 3 {
                print("Select a new character:") // Asks each player to select their team
                if let choice = readLine() {
                    switch choice {
                    case "1":
                        player.team.append(createCharacter(job: .mercenary)!)
                    case "2":
                        player.team.append(createCharacter(job: .arbalester)!)
                    case "3":
                        player.team.append(createCharacter(job: .pyromaniac)!)
                    case "4":
                        player.team.append(createCharacter(job: .magus)!)
                    default:
                        print("Invalid input. Please try again.")
                    }
                }
            }
        }
        print("\nHere are the finalised teams:")
        for player in players {
            player.describeTeam()
        }
    }
    
    func createCharacter(job: JobType) -> Character? {
        print("Choose a name for your \(job):")
        guard let newName = readLine() else {
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
    
    // A method to describe the available character types
    func describeJobs() {
        print("\nHere's a list of the jobs available and their related skills:") // A brief description for the player
        let playableCharacters = [Mercenary(name: nil), Arbalester(name: nil), Pyromaniac(name: nil), Magus(name: nil)] // An array containing all available characters without names
        for character in playableCharacters { // A for-in that goes through the 'playableCharacters' array
            character.describe() // Calls the so-called method for each character
        }
    }
    
    // MARK: Fight
    func fight() {
        print("\nNow let the fight begin!")
        var remainingPlayers = players
        while numberOfPlayers > 1 {
            for i in 0...remainingPlayers.count-1 {
                let activePlayer = remainingPlayers[i]
                if activePlayer.team[0].isDead && activePlayer.team[1].isDead && activePlayer.team[2].isDead {
                    print("\n\(activePlayer.name.uppercased())'S TEAM IS DEAD.")
                } else {
                    print("\n\(activePlayer.name.uppercased())'S TURN:")
                    print(activePlayer.team[0].swopsWeapon())
       //             if chestAppears() {
       //                 print(activePlayer.chestDecision())
       //             }
                    if let ally = activePlayer.selectAlly() {
                        if ally.job == "magus" {
                            if let allyTarget = activePlayer.selectAlly() {
                                ally.action(targetCharacter: allyTarget)
                            }
                        } else {
                            if let enemy = activePlayer.selectEnemy(amongst: remainingPlayers){
                                ally.action(targetCharacter: enemy)
                            }
                        }
                    }
                }
                numberOfRounds += 1
            }
            print("\nCurrent statistics:")
            for player in players {
                player.showStats()
            }
            var numberOfDeadTeams = 0
            var deadTeamIndices: [Int] = []
            for i in 0...remainingPlayers.count-1 {
                if remainingPlayers[i].team[0].isDead && remainingPlayers[i].team[1].isDead && remainingPlayers[i].team[2].isDead {
                    numberOfDeadTeams += 1
                    deadTeamIndices.append(i)
                }
            }
            numberOfPlayers -= numberOfDeadTeams
            for i in deadTeamIndices {
                remainingPlayers.remove(at: i)
            }
        }
        print("\nGAME OVER!"
            + "\n\(remainingPlayers[0].name) wins the battle in \(numberOfRounds) rounds!")
    }
    
    func chestAppears() {
        print("A chest appears in front of ")
    }
}
