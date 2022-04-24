//
//  Settings.swift
//  SpaceAction
//
//  Created by A on 4/15/22.
//

import Foundation
import SpriteKit

class Settings: Codable {
    var spaceshipName: String?
    var timer: Double?
    
    init(spaceshipName: String?, timer: Double?) {
        self.spaceshipName = spaceshipName
        self.timer = timer
    }

    private enum CodingKeys: String, CodingKey {
        case spaceshipName
        case timer
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        spaceshipName = try container.decodeIfPresent(String.self, forKey: .spaceshipName)
        timer = try container.decodeIfPresent(Double.self, forKey: .timer)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.spaceshipName, forKey: .spaceshipName)
        try container.encode(self.timer, forKey: .timer)
    }
}
