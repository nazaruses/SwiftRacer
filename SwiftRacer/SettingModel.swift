//
//  SettingModel.swift
//  SwiftRacer
//
//  Created by Nazar Dremach on 22/7/23.
//

import Foundation

struct Setting {
    let settingName: String
    let type: SettingType
    var settingValue: Any
    
}

enum SettingType {
    case switchSetting
        case openSetting
}
