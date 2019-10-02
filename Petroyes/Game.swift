//
//  Game.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

class Game {
    // Enumeration to deal with the game's state
    enum State {
        case ongoing, over
    }
    
    // A series of properties that will be useful to the gameplay
    var players: [Player] = [] // An array containing the players
    let playableCharacters = [Mercenary(), Arbalester(), Pyromaniac(), Magus()] // An array containing the character's types
    var numberOfRounds = 0 // Counts the number of rounds
    static var existingCharacterNames = [String]() // Stores the character names that were already created by other players and can't be used again
    enum JobType {
        case mercenary, arbalester, pyromaniac, magus
    }
    
    // A method that will be called each time a new game begins
    func initiateNewGame() {
        numberOfRounds = 0 // Resets the number of rounds to 0
        print("\n\nWelcome to Petroyes.") // Prints a greeting for the players
        for i in 1...2 {
            let player = Player(number: Int(i))
            players.append(player)
        }
        print("\n\(players[0].name) and \(players[1].name) will have a fight today!") // Prints a catch phrase to arouse the players
        describeJobs() // Calls the so called method
        createTeams() // Calls the so called method
        battle()
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
                        player.team.append(createCharacter(job: .mercenary))
                    case "2":
                        player.team.append(createCharacter(job: .arbalester))
                    case "3":
                        player.team.append(createCharacter(job: .pyromaniac))
                    case "4":
                        player.team.append(createCharacter(job: .magus))
                    default:
                        print("Invalid input. Please try again.")
                    }
                }
            }
        }
        print("\nHere are the finalized teams:")
        for player in players {
            player.describeTeam()
        }
        print("\nNow let the fight begin!")
    }
    
    func createCharacter(job: JobType) -> Character {
        switch job {
        case .mercenary:
            let newMercenary = Mercenary()
            newMercenary.giveName()
            return newMercenary
        case .arbalester:
            let newArbalester = Arbalester()
            newArbalester.giveName()
            return newArbalester
        case .pyromaniac:
            let newPyromaniac = Pyromaniac()
            newPyromaniac.giveName()
            return newPyromaniac
        case .magus:
            let newMagus = Magus()
            newMagus.giveName()
            return newMagus
        }
    }
    
    // A method to describe the available character types
    func describeJobs() {
        print("\nHere's a list of the jobs available and their related skills:") // A brief description for the player
        for character in playableCharacters { // A for-in that goes through the 'playableCharacters' array
            character.describe() // Calls the so-called method for each character
        }
    }
    
    func battle() {
        
    }
}
