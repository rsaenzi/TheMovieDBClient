//
//  LogLevel.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 8/5/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

enum LogLevel: Int {
    
    case fatal
    case error
    case warning
    case important
    case info
    case debug
    
    func icon() -> String {
        
        switch self {
            
        case .fatal:
            return "🆘"
        case .error:
            return "❌"
        case .warning:
            return "⚠️"
        case .important:
            return "💎"
        case .info:
            return "ℹ️"
        case .debug:
            return "🌀"
        }
    }
}
