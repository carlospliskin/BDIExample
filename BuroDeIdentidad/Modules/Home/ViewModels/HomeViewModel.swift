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
    @Published var errorMessage: String? = nil
    
    private var cancellable: AnyCancellable?

    func fetchUser() {
        guard let url = URL(string: "https://randomuser.me/api/") else {
            self.errorMessage = "URL inválida"
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Error al obtener usuario: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] users in
                self?.users.append(contentsOf: users)
            })
    }
}//class
