//
//  splashView.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//  
//

import SwiftUI

struct splashView: View {
    @StateObject private var viewModel = splashViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Buro de Identidad")
                .font(.largeTitle)
                .padding()
        }
        .onAppear {
            viewModel.startTimer()
        }
        .fullScreenCover(isPresented: $viewModel.isActive) {
            ContentView()
        }
    }
}

//Nota: version for xcode 15
#Preview {
    splashView()
}
