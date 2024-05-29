//
//  editUserView.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//

import SwiftUI

struct EditUserView: View {
    @State var user: User
    
    var body: some View {
        VStack {
            HStack {
                Text("Editar Usuario")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                Image(systemName: "pencil.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding()
            }
            
            Form {
                Section(header: Text("Nombre")) {
                    TextField("Título", text: $user.name.title)
                        .keyboardType(.alphabet)
                    TextField("Primer Nombre", text: $user.name.first)
                        .keyboardType(.alphabet)
                    TextField("Apellido", text: $user.name.last)
                        .keyboardType(.alphabet)
                }
                
                Section(header: Text("Dirección")) {
                    TextField("Ciudad", text: $user.location.city)
                        .keyboardType(.alphabet)
                    TextField("Estado", text: $user.location.state)
                        .keyboardType(.alphabet)
                    TextField("País", text: $user.location.country)
                        .keyboardType(.alphabet)
                    TextField("Código Postal", text: $user.location.postcode)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Correo Electrónico")) {
                    TextField("Email", text: $user.email)
                        .keyboardType(.emailAddress)
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Text("Nombre del participante")
                Spacer()
                Text("\(Date(), formatter: dateFormatter)")
                    .onAppear(perform: updateTime)
                    .onReceive(timer) { _ in
                        updateTime()
                    }
                Spacer()
            }
            .padding()
        }
    }
    
    private func updateTime() {
        let currentDate = Date()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    }
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return formatter
    }()
}

extension EditUserView {
    init(user: User) {
        _user = State(initialValue: user)
    }
}


