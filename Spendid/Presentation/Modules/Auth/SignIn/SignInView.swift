//
//  SignInView.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import SwiftUI

struct SignInView: View {

  @ObservedObject var viewModel: SignInViewModel

  var body: some View {
    VStack {
      TextField("Email", text: $viewModel.email)
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .autocorrectionDisabled()

      SecureField("Password", text: $viewModel.password)

      Button {
        viewModel.didTapSignIn()
      } label: {
        Text("Sign In")
          .font(.callout)
      }
      .buttonStyle(.borderedProminent)

      Button {
        viewModel.didTapSignUp()
      } label: {
        Text("Don't have an account ? Sign Up")
      }
    }
    .textFieldStyle(.roundedBorder)
    .frame(width: 288)
  }

}

#Preview {
  SignInView(viewModel: SignInViewModel(authService: AuthenticationService(),onTappingSignUp: { }))
}
