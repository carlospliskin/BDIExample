//
//  splashViewModel.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//  
//

import Foundation
import SwiftUI

class splashViewModel: ObservableObject {
    @Published var isActive = false

    func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isActive = true
        }
    }
}//class
