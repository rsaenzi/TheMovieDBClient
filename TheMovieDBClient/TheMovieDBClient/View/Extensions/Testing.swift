//
//  Testing.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 8/4/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//


import Foundation

class Test {
    
    static private var testingEnabled = false
    static private var endpointResult = ""
    static public let expectationTimeout: TimeInterval = 60
    
    static func enableTestingMode() {
        if BuildConfiguration.isNotRelease {
            Test.testingEnabled = true
        }
    }
    
    static func isTesting() -> Bool {
        return testingEnabled
    }
}

// MARK: Endpoint
extension Test {
    
    static func setEndpointResult(_ string: String) {
        guard testingEnabled == true else { return }
        
        endpointResult = string
    }
    
    static func setEndpointResult(fromFile file: TestFile) {
        guard testingEnabled == true else { return }
        
        endpointResult = read(file: file) ?? ""
    }
    
    static func getSampleData(for endpoint: ApiEndpoint) -> String {
        guard testingEnabled == true else { return "" }
        
        return endpointResult
    }
}

// MARK: File
extension Test {
    
    static private func read(file: TestFile) -> String? {
        guard testingEnabled == true else { return nil }
        
        guard let path = Bundle.main.path(forResource: file.rawValue, ofType: "json") else {
            return nil
        }
        
        let fileContent = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        
        return fileContent
    }
}

enum TestFile: String {
    case getConfigurationEmpty
}
