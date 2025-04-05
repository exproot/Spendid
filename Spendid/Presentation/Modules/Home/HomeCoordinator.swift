//
//  HomeCoordinator.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import DependencyContainer
import SwiftUI

final class HomeCoordinator {

  weak var navigationController: UINavigationController?

  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }

  func makeViewController() -> UIViewController {
    let authService = DC.shared.resolve(type: .singleInstance, for: AuthenticationServiceProtocol.self)
    let viewModel = HomeViewModel(authService: authService)
    let view = HomeView(viewModel: viewModel)
    let hostingVC = UIHostingController(rootView: view)
    return hostingVC
  }

}
