//
//  HomeView.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//  
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var username: String = "Administrador" // Assuming the username is "Administrador"

    var body: some View {
        VStack {
            HeaderView(username: username) {
                logout()
            }
            .padding(.bottom, 10)
            
            HStack {
                Spacer()
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
            }
            
            Button(action: {
                viewModel.fetchUser()
            }) {
                Text("Obtener Usuario")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            List(viewModel.users) { user in
                NavigationLink(destination: EditUserView(user: user)) {
                    VStack(alignment: .leading) {
                        Text("\(user.name.title) \(user.name.first) \(user.name.last)")
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                    }
                }
            }
            FooterView()
        }
        .navigationTitle("Usuarios")
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func logout() {
        // Clear session and redirect to login
        UserDefaults.standard.removeObject(forKey: "lastSessionDate")
        loginViewModel.isLoggedIn = false
    }
}

//#Preview {
//    HomeView()
//}
