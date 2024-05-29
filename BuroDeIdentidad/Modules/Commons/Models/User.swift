//
//  User.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//

import Foundation

struct User: Codable, Identifiable {
    let id = UUID()
    var name: Name
    var location: Location
    var email: String
    
    struct Name: Codable {
        var title: String
        var first: String
        var last: String
    }

    struct Location: Codable {
        var street: Street
        var city: String
        var state: String
        var country: String
        var postcode: String
        
        struct Street: Codable {
            var number: Int
            var name: String
        }
    }
}

struct UserResponse: Codable {
    let results: [User]
}
