//
//  AppConfig.swift
//  TodosDemo
//
//  Created by AMALITECH-PC-593 on 10/9/24.
//

import Foundation

final class AppConfig {

    // MARK: life cycle methods

    private init() { }

    // MARK: public variables

    static let shared = AppConfig()

    var baseURL: String {
        fetch(key: .baseURL)
    }

    // MARK: public methods

    func fetch(key: Key) -> String {
        guard let value =  Bundle.main.object(
            forInfoDictionaryKey: key.rawValue
        ) as? String else {
            return ""
        }
        return parseValue(value: value, key: .baseURL)
    }

    // MARK: private methods

    private func parseValue(
        value: String, key: Key
    ) -> String {
        switch key {
        case .baseURL:
            return "https://" + value
        }
    }
}

enum Key: String {
    case baseURL
}
