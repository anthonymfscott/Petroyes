//
//  Game.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

public final class Game {
    // MARK: Properties
    private var numberOfPlayers: Int
    private var players: [Player] = [] // An array containing the players
    private var numberOfRounds: Int // Counts the number of rounds
    internal static var existingCharacterNames: [String] = [] // Stores the character names that were already created by other players and can't be used again
    
    // MARK: Creation of the game
    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers // Sets a specific number of players
        numberOfRounds = 0 // Resets the number of rounds to 0
    }
    
    func startGame() {
        print("WELCOME TO PETROYES!")
        createPlayers()
        describeJobs()
        createTeams()
        fight()
    }
    
    private func createPlayers() {
        for playerNumber in 1...numberOfPlayers {
            let newPlayer = Player(number: Int(playerNumber)) // Creates desired number of instances of Player
            players.append(newPlayer) // Adds each instance to 'players' array
        }
    }
    
    private func describeJobs() {
        print("\nHere's a list of the jobs available and their related skills:")
        let playableCharacters = [Mercenary(), Arbalester(), Pyromaniac(), Magus()] // Creates an array containing instances of all available characters without names
        for playableCharacter in playableCharacters {
            playableCharacter.describe() // Calls the 'describe' method for each character
        }
    }
    
    private func createTeams() {
        for player in players {
            player.selectCharacters() // Calls the 'selectCharacters' method for each player
        }
        print("\nHere are the finalised teams:")
        for player in players {
            player.showStats() // Calls the 'showStats' method for each player
        }
    }
    
    // MARK: Fight phase
    private func fight() {
        print("\nNow let the fight begin!")
        var remainingPlayers = players // Creates a copy of the 'players' array, to be modified afterwards
        while numberOfPlayers > 1 { // As long as there's more than a player left:
            round(remainingPlayers: remainingPlayers) // - goes through a round of fighting with the remaining players
            remainingPlayers = removeDeadTeams(remainingPlayers: remainingPlayers) // - deletes the players whose teams are dead from the 'remainingPlayers' array
        }
        endGame(remainingPlayers: remainingPlayers) // Ends the game
    }
    
    private func round(remainingPlayers: [Player]) {
        numberOfRounds += 1 // Increments the number of rounds
        
        for activePlayer in remainingPlayers { // For every remaining player in turn:
            if activePlayer.teamIsDead() { // - checks if the player's team is dead and prints a message if it's the case
                print("\n\(activePlayer.name.uppercased())'S TEAM IS DEAD.")
            } else { // (if the player's team isn't dead:)
                print("\n\(activePlayer.name.uppercased())'S TURN:")
                
                if numberOfRounds > 3 && chestAppears() {
                    activePlayer.manageChest() // - calls the 'manageChest' method if a chest appears (option available after the third round only)
                }
                
                if let activeCharacter = activePlayer.selectAlly() { // - selects a character from the player's team to play the next action
                    if activeCharacter.job == "magus",
                        let ally = activePlayer.selectAlly() { // - selects an ally from the player's team (if the action is taken by a magus)
                        activeCharacter.takeAction(targetCharacter: ally) // - performs the action on the ally
                    } else if let enemy = activePlayer.selectEnemy(amongst: remainingPlayers) { // - selects an enemy amongst the remaining players' teams
                        activeCharacter.takeAction(targetCharacter: enemy) // - performs the action on the enemy
                    }
                }
            }
        }
        print("\nEnd of round \(numberOfRounds):")
        for player in players {
            player.showStats() // Shows statistics at the end of the round
        }
    }
    
    private func removeDeadTeams(remainingPlayers: [Player]) -> [Player] {
        var remainingPlayers = remainingPlayers
        var numberOfDeadTeams = 0 // Resets the count of dead teams to 0
        var deadTeamsIndices: [Int] = [] // Creates an empty array for all dead teams' indices
        for index in 0...remainingPlayers.count-1 { // For each player of the last round:
            if remainingPlayers[index].team[0].isDead && remainingPlayers[index].team[1].isDead && remainingPlayers[index].team[2].isDead { // (if all characters in the team are dead)
                numberOfDeadTeams += 1 // - records a dead team
                deadTeamsIndices.append(index) // - records the index of the KO player
            }
        }
        numberOfPlayers -= numberOfDeadTeams // Takes away the number of players that corresponds to the number of dead teams
        for index in deadTeamsIndices {
            remainingPlayers.remove(at: index) // Removes the KO players at the indices that were recorded above
        }
        return remainingPlayers // Returns the modified array
    }
    
    // MARK: Chest management
    private func chestAppears() -> Bool {
        let randomNumber = Int.random(in: 0...2) // Chooses a random number between 0, 1 and 2
        if randomNumber == 0 {
            return true // Returns true if the number is 0
        } else {
            return false // Returns false in the two other cases (1 chance out of 3 for a chest to appear)
        }
    }
    
    
    // MARK: End of the game
    private func endGame(remainingPlayers: [Player]) {
        print("""
            \nGAME OVER!
            \(remainingPlayers[0].name) wins the battle in \(numberOfRounds) rounds!\n\n
            """) // Prints the main statistics of the game, with the only player left in the array
    }
}
