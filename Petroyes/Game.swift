//
//  Game.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

final public class Game {
    // MARK: Properties
    private var numberOfPlayers: Int
    private var players: [Player] = [] // An array containing the players
    private var numberOfRounds: Int // Counts the number of rounds
    internal static var existingCharacterNames: [String] = [] // Stores the character names that were already created by other players and can't be used again
    
    // MARK: Initialisation
    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers // Sets a specific number of players
        numberOfRounds = 0 // Resets the number of rounds to 0
    }
    
    func startGame() {
        print("WELCOME TO PETROYES!")
        //     let welcome = NSLocalizedString("welcome_title", comment: "")
        //     print(welcome)
        // Creation of new players:
        for playerNumber in 1...numberOfPlayers {
            let newPlayer = Player(number: Int(playerNumber))
            players.append(newPlayer)
        }
        describeJobs() // Prints a description of the available character types
        createTeams() // Creates a team of characters for each player
        fight() // Starts the game
    }
    
    private func describeJobs() {
          print("\nHere's a list of the jobs available and their related skills:") // A brief description for the player
          let playableCharacters = [Mercenary(), Arbalester(), Pyromaniac(), Magus()] // An array containing all available characters without names
          for playableCharacter in playableCharacters { // A for-in that goes through the 'playableCharacters' array
              playableCharacter.describe() // Calls the so-called method for each character
          }
      }
    
    private func createTeams() {
        for player in players { // A for-in that goes through the 'players' array
            player.selectCharacters()
        }
        print("\nHere are the finalised teams:")
        for player in players {
            player.showStats()
        }
    }
    
    // MARK: Fight
    private func fight() {
        print("\nNow let the fight begin!")
        var remainingPlayers = players
        while numberOfPlayers > 1 {
            numberOfRounds += 1
            for activePlayer in remainingPlayers {
                if activePlayer.teamIsDead() {
                    print("\n\(activePlayer.name.uppercased())'S TEAM IS DEAD.")
                } else {
                    print("\n\(activePlayer.name.uppercased())'S TURN:")
                    if numberOfRounds > 3 && chestAppears() {
                        activePlayer.chest()
                    }
                    if let ally = activePlayer.selectAlly() {
                        if ally.job == "magus" {
                            if let allyTarget = activePlayer.selectAlly() {
                                ally.action(targetCharacter: allyTarget)
                            }
                        } else {
                            if let enemy = activePlayer.selectEnemy(amongst: remainingPlayers) {
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
            remainingPlayers = removeDeadTeams(remainingPlayers: remainingPlayers)
        }
        print("""
            \nGAME OVER!
            \(remainingPlayers[0].name) wins the battle in \(numberOfRounds) rounds!\n\n
            """)
    }
    
    private func chestAppears() -> Bool {
        let randomNumber = Int.random(in: 0...2)
        if randomNumber == 0 {
            return true
        } else {
            return false
        }
    }
    
    private func removeDeadTeams(remainingPlayers: [Player]) -> [Player] {
        var remainingPlayers = remainingPlayers
        var numberOfDeadTeams = 0
        var deadTeamIndices: [Int] = []
        for index in 0...remainingPlayers.count-1 {
            if remainingPlayers[index].team[0].isDead && remainingPlayers[index].team[1].isDead && remainingPlayers[index].team[2].isDead {
                numberOfDeadTeams += 1
                deadTeamIndices.append(index)
            }
        }
        numberOfPlayers -= numberOfDeadTeams
        for index in deadTeamIndices {
            remainingPlayers.remove(at: index)
        }
        return remainingPlayers
    }
}
