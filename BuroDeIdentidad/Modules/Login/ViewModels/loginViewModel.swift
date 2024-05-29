//
//  loginViewModel.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//  
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var error: String?
    
    func login(username: String, password: String) {
        if username == "Administrador" && password == "Admin123" {
            UserDefaults.standard.set(Date(), forKey: "lastSessionDate")
            self.isLoggedIn = true
        } else {
            // Handle login failure
        }
    }
}
