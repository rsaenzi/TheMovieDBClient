//
//  Log.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Foundation

final class Log {
    
    // Singleton
    static let shared = Log()
    
    // State
    private let dateFormatter = DateFormatter()
    private let minLevel = LogLevel.debug
    
    
    private init() {
        dateFormatter.dateFormat = "EEEE dd MMM yyyy HH:mm:ss(SSS) ZZZZ"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
    }
    
    func log(_ item: @autoclosure () -> Any?,
             as level: LogLevel = .debug,
             from system: LogSystem = .general,
             _ fileName: String = #file,
             _ functionName: String = #function,
             _ lineNumber: Int = #line,
             _ lineColumn: Int = #column) {
        
        // Nothing is printed if app is production...
        guard BuildConfiguration.isNotRelease else {
            return
        }
        
        // Nothing is printed if logging level is higher
        guard level.rawValue <= minLevel.rawValue else {
            return
        }
        
        // Gather all the required data
        let time = getCurrentTime()
        let file = cleanFileName(fileName)
        let icons = String(repeating: level.icon(), count: 5)
        
        // Builds the header
        var header = "\n\n\(icons)  "
        header += "[\(system.icon()) \(system.rawValue)]  "
        header += "[📂 \(file) → \(functionName) → Line \(lineNumber) Column \(lineColumn)]  "
        header += "[⏱ \(time)]  "
        header += "\(icons)"
        
        // Validate the content to log
        var content = ""
        if let validItem = item() {
            content = "\(validItem)"
        } else {
            content = "nil"
        }
        
        // Finally we print all the data
        let data = "\(header)\n\(content)"
        print(data)
    }
    
    func log(message: LogMessage,
             json encodable: Encodable? = nil,
             as level: LogLevel = .debug,
             from system: LogSystem = .general,
             _ fileName: String = #file,
             _ functionName: String = #function,
             _ lineNumber: Int = #line,
             _ lineColumn: Int = #column) {
        
        var content = message.rawValue
        
        if let object = encodable,
            let json = object.toJson(using: dateFormatter) {
            content += "\n"
            content += json
        }
        
        self.log(content, as: level, from: system, fileName, functionName, lineNumber, lineColumn)
    }
    
    private func getCurrentTime() -> String {
        return dateFormatter.string(from: Date())
    }
    
    private func cleanFileName(_ filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}


extension Encodable {
    
    func toJson(using dateFormatter: DateFormatter) -> String? {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData: Data
        
        do {
            jsonData = try encoder.encode(self)
            
        } catch {
            return nil
        }
        
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }
        
        guard jsonString.count > 0 else {
            return nil
        }
        
        return jsonString
    }
}


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

enum LogSystem: String {
    
    case general
    case firebase
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
        case .firebase:
            return "🌎"
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


// swiftlint:disable line_length
enum LogMessage: String {
    case noConnection = "No WiFi or Cellular connection available"
    case fetchKeychainError = "Can not fetch token from Keychain to authenticate the request"
    case noteNewVsExistingUsers = "At this point is ok if 'user' is not present in the json string, that is used to differentiate between new and existing users"
    case updateCustomerNoId = "No id returned when trying to update customer"
}
