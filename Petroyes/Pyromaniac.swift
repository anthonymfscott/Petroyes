//
//  Pyromaniac.swift
//  Petroyes
//
//  Created by Tony Scott enfant Depaepe on 16/10/2019.
//  Copyright © 2019 anthonymfscott. All rights reserved.
//

import Foundation

public class Pyromaniac: Character {
    override init(name: String = "") {
        super.init(name: name)
        job = "pyromaniac"
        hp = 80
        availableWeapons = [blowtorch, matchbox, flamethrower]
        weapon = availableWeapons[0]
        description = "Pyromaniacs love throwing devastating fire at their enemies... but are less resistant than their peers."
    }
}
