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
        Form {
            Section(header: Text("Nombre")) {
                TextField("Título", text: $user.name.title)
                TextField("Nombre", text: $user.name.first)
                TextField("Apellido", text: $user.name.last)
            }
            
            Section(header: Text("Dirección")) {
                TextField("Ciudad", text: $user.location.city)
                TextField("Estado", text: $user.location.state)
                TextField("País", text: $user.location.country)
                TextField("Código Postal", text: $user.location.postcode)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Correo")) {
                TextField("Correo", text: $user.email)
                    .keyboardType(.emailAddress)
            }
        }
        .navigationTitle("Editar Usuario")
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(user: User(name: .init(title: "Mr", first: "John", last: "Doe"), location: .init(city: "City", state: "State", country: "Country", postcode: "12345"), email: "john.doe@example.com"))
    }
}
