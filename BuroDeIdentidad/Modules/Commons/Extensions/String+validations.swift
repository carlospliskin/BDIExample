//
//  String+validations.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
