//
//  SettingsManager.swift
//  Swift Racer
//
//  Created by Nazar Dremach on 23/7/23.
//

import Foundation

class SettingsManager {
    static var shared = SettingsManager()
    private init() { }
    var settings = [
        Setting(settingName: "Music",
                type: .switchSetting,
                settingValue: true),
        Setting(settingName: "Sound",
                type: .switchSetting,
                settingValue: true),
        Setting(settingName: "Obstacles",
                type: .openSetting,
                settingValue: "Cars"),
        Setting(settingName: "Car Color",
                type: .openSetting,
                settingValue: "Red"),
        Setting(settingName: "User Name",
                type: .stringSetting,
                settingValue: "Your Name")
    ]
    
}
