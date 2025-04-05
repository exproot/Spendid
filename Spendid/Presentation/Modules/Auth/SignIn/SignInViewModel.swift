//
//  SignInViewModel.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//


import SwiftUI

class SignInViewModel: ObservableObject {

  @Published var email: String = ""
  @Published var password: String = ""

  private let authService: AuthenticationServiceProtocol
  private let onTappingSignUp: () -> Void

  init(authService: AuthenticationServiceProtocol, onTappingSignUp: @escaping () -> Void) {
    self.authService = authService
    self.onTappingSignUp = onTappingSignUp
  }

  func didTapSignUp() {
    onTappingSignUp()
  }

  func didTapSignIn() {
    let request = AuthRequest(email: email, password: password)
    authService.signIn(with: request) { error in
      if let error {
        print(error.localizedDescription)
      }
    }
  }

}
