//
//  ProfileViewModel.swift
//  MessengerApp
//
//  Created by Chukwuemeka Jennifer on 01/12/2021.
//

import Foundation
enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}

