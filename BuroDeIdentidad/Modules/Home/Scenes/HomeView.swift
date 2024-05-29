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

    var body: some View {
        VStack {
            HeaderView(username: "Administrador") {
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("Aceptar")))
        }
    }

    private func logout() {
        UserDefaults.standard.removeObject(forKey: "lastSessionDate")
        loginViewModel.isLoggedIn = false
    }
}

//#Preview {
//    HomeView()
//}
