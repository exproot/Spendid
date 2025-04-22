//
//  SignInViewModel.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import Combine
import SwiftUI

class SignInViewModel: ObservableObject {

  @Published var email: String = ""
  @Published var password: String = ""
  @Published var canSubmit: Bool = false
  @Published var isErrorPresented: Bool = false
  @Published var errorMessage: String = ""

  private var cancellables = Set<AnyCancellable>()

  private let authService: AuthenticationServiceProtocol
  private let onTappingSignUp: () -> Void

  init(authService: AuthenticationServiceProtocol, onTappingSignUp: @escaping () -> Void) {
    self.authService = authService
    self.onTappingSignUp = onTappingSignUp

    isFormValidPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.canSubmit, on: self)
      .store(in: &cancellables)
  }

  var isEmailValidPublisher: AnyPublisher<Bool, Never> {
    $email
      .debounce(for: 0.5, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { email in
        return FormValidator.validateEmail(email)
      }
      .eraseToAnyPublisher()
  }

  var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
    $password
      .debounce(for: 0.5, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { password in
        return !password.isEmpty
      }
      .eraseToAnyPublisher()
  }

  var isFormValidPublisher: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest(isEmailValidPublisher, isPasswordValidPublisher)
      .map { isValidEmail, isValidPassword in
        return isValidEmail && isValidPassword
      }
      .eraseToAnyPublisher()
  }

  func didTapSignUp() {
    onTappingSignUp()
  }

  func didTapSignIn() {
    let request = AuthRequest(email: email, password: password)
    
    authService.signIn(with: request) { [weak self] error in
      if let error {
        DispatchQueue.main.async {
          self?.isErrorPresented = true
          self?.errorMessage = error.localizedDescription
        }
      }
    }
  }

}
