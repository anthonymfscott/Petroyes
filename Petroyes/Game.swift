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
    private var numberOfPlayers: Int
    private var players: [Player] = [] // An array containing the players
    private var numberOfRounds: Int // Counts the number of rounds
    static var existingCharacterNames: [String] = [] // Stores the character names that were already created by other players and can't be used again
    enum JobType {
        case mercenary, arbalester, pyromaniac, magus
    }
    
    // MARK: Initialisation
    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers // Sets a specific number of players
        numberOfRounds = 0 // Resets the number of rounds to 0
        print("WELCOME TO PETROYES.")
        // Creation of new players:
        for playerNumber in 1...numberOfPlayers {
            let newPlayer = Player(number: Int(playerNumber))
            players.append(newPlayer)
        }
        describeJobs() // Prints a description of the available character types
        createTeams() // Creates a team of characters for each player
        fight() // Starts the game
    }
    
    func describeJobs() {
          print("\nHere's a list of the jobs available and their related skills:") // A brief description for the player
          let playableCharacters = [Mercenary(), Arbalester(), Pyromaniac(), Magus()] // An array containing all available characters without names
          for playableCharacter in playableCharacters { // A for-in that goes through the 'playableCharacters' array
              playableCharacter.describeJob() // Calls the so-called method for each character
          }
      }
    
    func createTeams() {
        for player in players { // A for-in that goes through the 'players' array
            print("""
                \n\(player.name), you can now choose 3 characters for your team.
                (1 = mercenary, 2 = arbalester, 3 = pyromaniac, 4 = magus)
                """)
            while player.team.count < 3 {
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
                        player.team.append(character)
                    } else {
                        print("The name can't be empty. Please try another input.")
                        return
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
        if let newName = readLine() {
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
    
    // MARK: Fight
    func fight() {
        print("\nNow let the fight begin!")
        var remainingPlayers = players
        while numberOfPlayers > 1 {
            numberOfRounds += 1
            for activePlayer in remainingPlayers {
                if activePlayer.team[0].isDead && activePlayer.team[1].isDead && activePlayer.team[2].isDead {
                    print("\n\(activePlayer.name.uppercased())'S TEAM IS DEAD.")
                } else {
                    print("\n\(activePlayer.name.uppercased())'S TURN:")
                    if numberOfRounds > 3 && chestAppears() {
                        let randomIndex = Int.random(in: 0...2)
                        if !activePlayer.team[randomIndex].isDead {
                            print("""
                                A chest magically appears in front of \(activePlayer.team[randomIndex].name)!
                                Would you like to open it and swap \(activePlayer.team[randomIndex].name)'s \(activePlayer.team[randomIndex].weapon.name) for the weapon that's hidden inside? (Y/N)
                                """)
                            if let answer = readLine() {
                                switch answer.lowercased() {
                                case "y":
                                    print(activePlayer.team[randomIndex].swapsWeapon())
                                case "n":
                                    print("\(activePlayer.team[randomIndex].name) doesn't open the chest. The battle continues!")
                                default:
                                    print("Invalid input. The battle continues...")
                                }
                            }
                        }
                    }
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
            }
            print("\nEnd of round \(numberOfRounds):")
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
        print("""
            \nGAME OVER!
            \(remainingPlayers[0].name) wins the battle in \(numberOfRounds) rounds!\n\n
            """)
    }
    
    func chestAppears() -> Bool {
        let randomNumber = Int.random(in: 0...2)
        if randomNumber == 0 {
            return true
        } else {
            return false
        }
    }
}
