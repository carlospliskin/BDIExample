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
        var city: String?
        var state: String?
        var country: String?
        var postcode: Postcode
        
        struct Street: Codable {
            var number: Int?
            var name: String?
        }
    }
}

struct UserResponse: Codable {
    let results: [User]
}

enum Postcode: Codable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected Int or String"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intValue):
            try container.encode(intValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
}
