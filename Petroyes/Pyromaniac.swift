//
//  Pyromaniac.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 16/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

final class Pyromaniac: Character {
    private let blowtorch = Weapon(name: "blowtorch", actionPoints: 25)
    private let matchbox = Weapon(name: "matchbox", actionPoints: 12)
    private let flamethrower = Weapon(name: "flamethrower", actionPoints: 50)
    
    override init(name: String = "") {
        super.init(name: name)
        job = "pyromaniac"
        hp = 80
        availableWeapons = [blowtorch, matchbox, flamethrower]
        weapon = availableWeapons[0]
        description = "Pyromaniacs love throwing devastating fire at their enemies... but are less resistant than their peers."
    }
}
