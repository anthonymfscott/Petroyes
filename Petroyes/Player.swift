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
        print("\n\(name.uppercased())'S TEAM:", terminator: "")
        for character in team {
            character.describe()
        }
    }
    
    func showStats() {
        print("\n\(name.uppercased())'S TEAM:")
        for character in team {
            character.stats()
        }
    }
    
    func selectAlly() -> Character? {
        var allies: [Character] = []
        for i in 0...team.count - 1 {
            if !team[i].isDead {
                allies.append(team[i])
            }
        }
        var listOfRemainingAllies = ""
        for i in 0...allies.count - 1 {
            listOfRemainingAllies += "\(i+1) = \(allies[i].name!)."
        }
        print("""
            Select one of your allies for the next action:
            (\(listOfRemainingAllies))
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
        for i in 0...players.count -  1 {
            if players[i] !== self {
                for j in 0...players[i].team.count - 1 {
                    if !players[i].team[j].isDead {
                        enemies.append(players[i].team[j])
                    }
                }
            }
        }
        var listOfRemainingEnemies = ""
        for i in 0...enemies.count - 1 {
            listOfRemainingEnemies += "\(i+1) = \(enemies[i].name!)."
        }
        print("""
            Select an enemy for the next action:
            (\(listOfRemainingEnemies))
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
