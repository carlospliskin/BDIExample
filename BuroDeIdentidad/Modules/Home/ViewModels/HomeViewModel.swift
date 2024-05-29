//
//  HomeViewModel.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//  
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    func fetchUser() {
        let url = URL(string: "https://randomuser.me/api/")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load user: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }
            
            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    self.users.append(contentsOf: userResponse.results)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode user: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}//class
