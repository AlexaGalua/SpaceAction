//
//  SettingsManager.swift
//  SpaceAction
//
//  Created by A on 4/15/22.
//

import Foundation
import SpriteKit

enum SettingKeys: String {
    case settingsKey
}

class SettingsManager {
    
    static let shared = SettingsManager()
    
    private init() {}
    
    func saveSettings(_ settings: Settings) {
        UserDefaults.standard.set(encodable: settings, forKey: SettingKeys.settingsKey.rawValue)
    }
    
    func loadSettings() -> Settings {
        guard let settings = UserDefaults.standard.value(Settings.self, forKey: SettingKeys.settingsKey.rawValue) else {
            return Settings(playerName: nil, spaceshipName: nil, timer: nil)
        }
        return settings
    }
}
