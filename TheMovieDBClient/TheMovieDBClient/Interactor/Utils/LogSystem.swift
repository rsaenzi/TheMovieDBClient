//
//  LogSystem.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 8/5/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

enum LogSystem: String {
    
    case general
    case keychain
    case apiRequest
    case apiResponse
    case viewController
    case presenter
    case interactor
    
    func icon() -> String {
        
        switch self {
            
        case .general:
            return "📱"
        case .keychain:
            return "🔑"
        case .apiRequest:
            return "📘"
        case .apiResponse:
            return "📗"
        case .viewController:
            return "🖥"
        case .presenter:
            return "📐"
        case .interactor:
            return "⚙️"
        }
    }
}
