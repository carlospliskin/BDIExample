//
//  editUserView.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//

import SwiftUI

struct EditUserView: View {
    @State var user: User
    var onSave: (User) -> Void
    
    var body: some View {
        HStack {
            Text("Editar Usuario")
                .font(.largeTitle)
                .padding()
            
            
            Image(systemName: "pencil.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
        }
        VStack {
            
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
                    TextField("Ciudad", text: Binding(
                        get: { user.location.city ?? "" },
                        set: { user.location.city = $0 }
                    ))
                    .keyboardType(.alphabet)
                    
                    TextField("Estado", text: Binding(
                        get: { user.location.state ?? "" },
                        set: { user.location.state = $0 }
                    ))
                    .keyboardType(.alphabet)
                    
                    TextField("País", text: Binding(
                        get: { user.location.country ?? "" },
                        set: { user.location.country = $0 }
                    ))
                    .keyboardType(.alphabet)
                    
                    TextField("Código Postal", text: Binding(
                        get: {
                            if case .string(let stringValue) = user.location.postcode {
                                return stringValue
                            } else {
                                return ""
                            }
                        },
                        set: { newValue in
                            user.location.postcode = .string(newValue)
                        }
                    ))
                    .keyboardType(.numberPad)
                }
                
                Section(header: Text("Correo Electrónico")) {
                    TextField("Email", text: $user.email)
                        .keyboardType(.emailAddress)
                }
            }
            .onAppear {
                updateTime()
            }
            .onReceive(timer) { _ in
                updateTime()
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
            .onDisappear {
                onSave(user)
            }
        }
        .padding()
    }
    
    private func updateTime() {
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
    init(user: User, onSave: @escaping (User) -> Void) {
        self._user = State(initialValue: user)
        self.onSave = onSave
    }
}
