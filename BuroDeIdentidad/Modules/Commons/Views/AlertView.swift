//
//  AlertView.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//

import Foundation
import SwiftUI

struct AlertView: View {
    @Binding var isPresented: Bool
    var title: String
    var message: String

    var body: some View {
        VStack {
            // Contenido de la vista principal (opcional)
        }
        .alert(isPresented: $isPresented) {
            Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("Aceptar")))
        }
    }
}
