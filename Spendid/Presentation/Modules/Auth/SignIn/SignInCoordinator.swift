//
//  SignInCoordinator.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import DependencyContainer
import SwiftUI

final class SignInCoordinator {

  weak var navigationController: UINavigationController?

  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }

  func makeViewController() -> UIViewController {
    let authService = DC.shared.resolve(type: .singleInstance, for: AuthenticationServiceProtocol.self)
    let viewModel = SignInViewModel(authService: authService,onTappingSignUp: goToSignUp)
    let view = SignInView(viewModel: viewModel)
    let hostingVC = UIHostingController(rootView: view)
    return hostingVC
  }

  private func goToSignUp() {
    let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
    let signUpVC = signUpCoordinator.makeViewController()

    navigationController?.pushViewController(signUpVC, animated: true)
  }

}
