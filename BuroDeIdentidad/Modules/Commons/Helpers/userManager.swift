//
//  userManager.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 29/05/24.
//

import Foundation

class UserManager: ObservableObject {
    @Published var currentUser: User
    
    private let userDefaultsKey = "currentUser"
    
    init(currentUser: User) {
        self.currentUser = currentUser
        loadCurrentUser()
    }
    
    private func loadCurrentUser() {
        if let savedUser = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decodedUser = try? JSONDecoder().decode(User.self, from: savedUser) {
                currentUser = decodedUser
            }
        }
    }
    
    func saveCurrentUserChanges() {
        if let encodedUser = try? JSONEncoder().encode(currentUser) {
            UserDefaults.standard.set(encodedUser, forKey: userDefaultsKey)
        }
    }
}
