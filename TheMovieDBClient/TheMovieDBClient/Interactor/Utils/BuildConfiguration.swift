//
//  BuildConfiguration.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

// For this to work, please add on "Other Swift Flags" the following keys:
// Key -D BUILD_CONFIG_DEBUG for Debug
// Key -D BUILD_CONFIG_RELEASE for Release

class BuildConfiguration {
    
    static var current: BuildConfigurationOption {
        
        #if BUILD_CONFIG_RELEASE
        return .release
        #endif
        
        #if BUILD_CONFIG_DEBUG
        return .debug
        #endif
    }
    
    static var isNotRelease: Bool {
        return current == .debug ? true : false
    }
}

enum BuildConfigurationOption {
    case release
    case debug
}
