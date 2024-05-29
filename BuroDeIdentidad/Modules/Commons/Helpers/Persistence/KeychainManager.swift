//
//  KeychainManager.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//

import Foundation
import Security

struct KeychainManager {
    static func saveCredentials(username: String, password: String) {
        guard let passwordData = password.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: "BuroDeIdentidad",
            kSecAttrAccount as String: username,
            kSecValueData as String: passwordData
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func getCredentials(username: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: "BuroDeIdentidad",
            kSecAttrAccount as String: username,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            let retrievedData = dataTypeRef as! Data
            let password = String(data: retrievedData, encoding: .utf8)
            return password
        } else {
            return nil
        }
    }

    static func deleteCredentials(username: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: "BuroDeIdentidad",
            kSecAttrAccount as String: username
        ]

        SecItemDelete(query as CFDictionary)
    }
}
