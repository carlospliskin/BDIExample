//
//  HomeView.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//  
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    
    @State private var showAlert = false
    @State private var selectedUser: User?

    var body: some View {
        VStack {
            HeaderView(username: "Administrador") {
                logout()
            }
            .padding(.bottom, 10)
            
            HStack {
                Text("Usuarios")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
            }

            // Move the button here, outside of the VStack
            Button(action: {
                viewModel.fetchUsers()
            }) {
                Text("Obtener Usuario")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            List(viewModel.users) { user in
                NavigationLink(destination: EditUserView(user: user, onSave: { updatedUser in
                    // Update user in the list
                    if let index = viewModel.users.firstIndex(where: { $0.id == updatedUser.id }) {
                        viewModel.users[index] = updatedUser
                    }
                })) {
                    VStack(alignment: .leading) {
                        Text("\(user.name.title) \(user.name.first) \(user.name.last)")
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                    }
                }
                .onTapGesture {
                    selectedUser = user // Asigna el usuario seleccionado
                }
            }

            // Footer
            FooterView()
        }
        .navigationTitle("Usuarios")
        .onChange(of: viewModel.errorMessage) { errorMessage in
            if errorMessage != nil {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("Aceptar")))
        }
    }

    private func logout() {
        UserDefaults.standard.removeObject(forKey: "lastSessionDate")
        loginViewModel.isLoggedIn = false
    }
}
