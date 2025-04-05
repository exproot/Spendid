//
//  SignUpCoordinator.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import DependencyContainer
import SwiftUI

final class SignUpCoordinator {

  weak var navigationController: UINavigationController?

  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }

  func makeViewController() -> UIViewController {
    let authService = DC.shared.resolve(type: .singleInstance, for: AuthenticationServiceProtocol.self)
    let viewModel = SignUpViewModel(authService: authService, onTappingSignIn: goToSignIn)
    let view = SignUpView(viewModel: viewModel)
    let hostingVC = UIHostingController(rootView: view)
    return hostingVC
  }

  private func goToSignIn() {
    navigationController?.popToRootViewController(animated: true)
  }

}
