//
//  HeaderFooterViews.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    let username: String
    let onLogout: () -> Void

    var body: some View {
        HStack {
            Text("Usuario: \(username)")
                .font(.headline)
            Spacer()
            Button(action: onLogout) {
                Text("Salir")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}

struct FooterView: View {
    @State private var currentTime = Date()

    var body: some View {
        HStack {
            Text("Participante: [Tu Nombre]")
            Spacer()
            Text(currentTime, style: .date)
            Text(currentTime, style: .time)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .onAppear {
            // Actualiza el tiempo cada segundo
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.currentTime = Date()
            }
        }
    }
}
