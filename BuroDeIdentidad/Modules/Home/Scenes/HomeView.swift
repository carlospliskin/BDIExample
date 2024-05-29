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
    @State private var showAlert = false
    @ObservedObject var loginViewModel: LoginViewModel

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
        .onChange(of: viewModel.errorMessage) { errorMessage in
            if errorMessage != nil {
                showAlert = true
            }
        }
        .background(
            AlertView(isPresented: $showAlert, title: "Error", message: viewModel.errorMessage ?? "")
        )
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
