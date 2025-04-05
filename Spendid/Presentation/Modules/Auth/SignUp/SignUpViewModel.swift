//
//  SignUpViewModel.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import Combine
import SwiftUI

class SignUpViewModel: ObservableObject {

  @Published var email: String = ""
  @Published var password: String = ""
  @Published var canSubmit: Bool =  false
  @Published var isErrorPresented: Bool = false
  @Published var errorMessage: String = ""

  private var cancellables = Set<AnyCancellable>()

  private let authService: AuthenticationServiceProtocol
  private let onTappingSignIn: () -> Void

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
        return FormValidator.validatePassword(password)
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

  init(authService: AuthenticationServiceProtocol, onTappingSignIn: @escaping () -> Void) {
    self.authService = authService
    self.onTappingSignIn = onTappingSignIn

    isFormValidPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.canSubmit, on: self)
      .store(in: &cancellables)
  }

  func didTapSignIn() {
    onTappingSignIn()
  }

  func createAccount() {
    let request = AuthRequest(email: email, password: password)

    authService.signUp(with: request) { [weak self] result, error in
      if let error {
        DispatchQueue.main.async {
          self?.isErrorPresented = true
          self?.errorMessage = error.localizedDescription
        }
      }
      print(result)
    }
  }

}

