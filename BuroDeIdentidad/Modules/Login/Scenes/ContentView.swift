//
//  ContentView.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var email: String = ""
    @State private var pass: String = ""
    @State private var color = Color.black.opacity(0.7)
    @State private var visible = false
    @State private var rememberPassword = UserDefaults.standard.bool(forKey: "rememberPassword")
    @StateObject private var loginViewModel = LoginViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isRegistering = false
    @State private var isForgotPassword = false

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100.0, height: 100, alignment: .top)
                Text("Inicia sesión")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                
                TextField("Correo", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6).stroke(Color.blue, lineWidth: 2))
                    .padding(.top, 0)
                
                HStack(spacing: 15) {
                    VStack {
                        if visible {
                            TextField("Contraseña", text: $pass)
                                .autocapitalization(.none)
                        } else {
                            SecureField("Contraseña", text: $pass)
                                .autocapitalization(.none)
                        }
                    }
                    Button(action: {
                        self.visible.toggle()
                    }) {
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(self.color)
                            .opacity(0.8)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0), lineWidth: 2))
                .padding(.top, 10)
                .onAppear {
                    if rememberPassword {
                        if let storedPass = KeychainManager.getCredentials(username: email) {
                            pass = storedPass
                        }
                    }
                }

                Toggle("Recordar contraseña", isOn: $rememberPassword)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .onChange(of: rememberPassword) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "rememberPassword")
                        rememberPassword = newValue
                    }

                Button(action: {
                    if pass.isEmpty {
                        self.loginViewModel.errorMessage = "Por favor, introduce tu contraseña"
                        return
                    }
                    if email.isValidEmail() {
                        if rememberPassword {
                            KeychainManager.saveCredentials(username: email, password: pass)
                        }
                        self.loginViewModel.login(username: email, password: pass)
                    } else {
                        self.loginViewModel.errorMessage = "Correo electrónico no válido"
                    }
                }) {
                    Text("Iniciar sesión")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .cornerRadius(6)
                .padding(.top, 15)
                .padding(.horizontal, 25)
                .navigationBarHidden(true)
                .alert(isPresented: Binding<Bool>(
                    get: { loginViewModel.errorMessage != nil },
                    set: { _ in loginViewModel.errorMessage = nil }
                )) {
                    Alert(title: Text("Error de inicio de sesión"), message: Text(loginViewModel.errorMessage ?? ""), dismissButton: .default(Text("Aceptar")))
                }

                HStack(spacing: 5) {
                    Text("¿No tienes una cuenta?")
                    NavigationLink(destination: RegistrerView(), isActive: $isRegistering) {
                        EmptyView()
                    }
                    Button(action: {
                        self.isRegistering = true
                    }) {
                        Text("Registrar")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 25)
            }
            .padding(.horizontal, 25)
            .background(
                NavigationLink(destination: HomeView(viewModel: homeViewModel, loginViewModel: loginViewModel), isActive: $loginViewModel.isLoggedIn) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .onAppear {
            checkSession()
        }
    }
    
    private func checkSession() {
        if let lastSessionDate = UserDefaults.standard.object(forKey: "lastSessionDate") as? Date {
            let currentTime = Date()
            let timeDifference = currentTime.timeIntervalSince(lastSessionDate)
            let timeLimit: TimeInterval = 180 // 3 minutes
            
            if timeDifference > timeLimit {
                showAlert = true
                alertTitle = "Sesión Expirada"
                alertMessage = "Ha pasado mucho tiempo desde la última sesión. Por favor, inicia sesión nuevamente."
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
