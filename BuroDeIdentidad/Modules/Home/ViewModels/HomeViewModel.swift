//
//  HomeViewModel.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//  
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    private var cancellable: AnyCancellable?
    
    func fetchUsers() {
        let url = URL(string: "https://randomuser.me/api/")!
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // Imprime el error para entender su naturaleza
                    print("Error fetching users:", error)
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { response in
                // No eliminamos los usuarios existentes, simplemente agregamos los nuevos
                self.users.append(contentsOf: response.results)
            })
    }

}//class
