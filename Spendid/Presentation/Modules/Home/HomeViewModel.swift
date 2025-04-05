//
//  HomeViewModel.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//


import SwiftUI

class HomeViewModel: ObservableObject {

  @Published var testText: String = ""

  private let authService: AuthenticationServiceProtocol

  init(authService: AuthenticationServiceProtocol) {
    self.authService = authService
  }

  func onAppear() {
    testText = "Spendid"
  }

  func didTapSignOut() {
    authService.signOutCurrentUser { error in
      if let error {
        print(error.localizedDescription)
      }
    }
  }

}
