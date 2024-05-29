//
//  HomeModel.swift
//  BuroDeIdentidad
//
//  Created by Carlos Paredes León on 28/05/24.
//  
//

import Foundation

/// Description: model with the information that should be shown in the view 
/// (the information is previously mapped to generate the model with the information that is needed in the view)
struct HomeVM {
    let id: Int
}

/// Description: model with the information that was obtained from the ws
/// Note: the model must be moved to the Entities folder
struct HomeEntity : Codable {
    let id: Int
}