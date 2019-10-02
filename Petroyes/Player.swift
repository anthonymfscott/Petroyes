//
//  Player.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 02/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

class Player {
    var number: Int
    var name = ""
    var team = [Character]()
    
    init(number: Int) {
        self.number = number
        print("\nChoose a name for Player \(number):")
        if let name = readLine() {
           self.name = name
        }
    }
    
    func describeTeam() {
        print("\nTEAM \(name.uppercased()):", terminator: "")
        for character in team {
            character.describe()
        }
    }
}
