//
//  Player.swift
//  Petroyes
//
//  Created by anthonymfscott on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

class Player {
    var number: Int
    var name = ""
    var team: [Character] = []
    
    init(number: Int) {
        self.number = number
        print("\nChoose a name for Player \(number):")
        if let name = readLine() {
           self.name = name
        }
    }
    
    func describeTeam() {
        print("-> \(name.uppercased())'S TEAM:")
        for character in team {
            character.shortlyDescribe()
        }
    }
    
    func showStats() {
        print("-> \(name.uppercased())'S TEAM:")
        for character in team {
            character.stats()
        }
    }
    
    func selectAlly() -> Character? {
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
