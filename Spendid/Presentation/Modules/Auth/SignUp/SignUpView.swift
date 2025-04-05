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
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()

      SecureField("Password", text: $viewModel.password)

      Button {
        viewModel.createAccount()
      } label: {
        Text("Sign Up")
          .frame(maxWidth: .infinity)
          .padding()
          .background(viewModel.canSubmit ? Color.blue : Color.gray)
          .foregroundStyle(Color.white)
          .clipShape(.rect(cornerRadius: 10))
          .font(.callout)
      }
      .disabled(!viewModel.canSubmit)

      Button {
        viewModel.didTapSignIn()
      } label: {
        Text("Already have an account ? Sign In")
      }
    }
    .alert("Auth Error", isPresented: $viewModel.isErrorPresented) {
      Button("Ok") { }
    } message: {
      Text(viewModel.errorMessage)
    }
    .textFieldStyle(.roundedBorder)
    .padding()

  }
}

#Preview {
  SignUpView(viewModel: SignUpViewModel(authService: AuthenticationService(), onTappingSignIn: { }))
}
