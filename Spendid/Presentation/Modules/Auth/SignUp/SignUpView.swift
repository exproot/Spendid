//
//  SignUpView.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import SwiftUI



struct SignUpView: View {

  @ObservedObject var viewModel: SignUpViewModel

  var body: some View {
    VStack(spacing: 20) {
      TextField("Email", text: $viewModel.email)
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .autocorrectionDisabled()

      SecureField("Password", text: $viewModel.password)
      SecureField("Password Confirmation", text: $viewModel.passwordConfirmation)

      Button {
        viewModel.createAccount()
      } label: {
        Text("Sign Up")
          .font(.callout)
      }
      .buttonStyle(.borderedProminent)

      Button {
        viewModel.didTapSignIn()
      } label: {
        Text("Already have an account ? Sign In")
      }
    }
    .textFieldStyle(.roundedBorder)
    .padding(.horizontal, 40)
  }

}

#Preview {
  SignUpView(viewModel: SignUpViewModel(authService: AuthenticationService(), onTappingSignIn: { }))
}
