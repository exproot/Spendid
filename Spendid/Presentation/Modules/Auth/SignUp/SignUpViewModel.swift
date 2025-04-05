//
//  SignUpViewModel.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//


import SwiftUI

class SignUpViewModel: ObservableObject {

  @Published var email: String = ""
  @Published var password: String = ""
  @Published var passwordConfirmation: String = ""

  private let authService: AuthenticationServiceProtocol
  private let onTappingSignIn: () -> Void

  init(authService: AuthenticationServiceProtocol, onTappingSignIn: @escaping () -> Void) {
    self.authService = authService
    self.onTappingSignIn = onTappingSignIn
  }

  func didTapSignIn() {
    onTappingSignIn()
  }

  func createAccount() {
    let request = AuthRequest(email: email, password: password)
    authService.signUp(with: request) { result, error in
      if let error {
        print(error.localizedDescription)
        return
      }

      print(result)
    }
  }

}
