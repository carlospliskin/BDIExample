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
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    func login(username: String, password: String) {
        if username == "Administrador@prueba.com" && password == "Admin123" {
            UserDefaults.standard.set(Date(), forKey: "lastSessionDate")
            DispatchQueue.main.async {
                self.isLoggedIn = true
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "Usuario o contraseña incorrectos"
            }
        }
    }
}
