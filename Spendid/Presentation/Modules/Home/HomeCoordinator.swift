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
    let firestoreService = DC.shared.resolve(type: .singleInstance, for: FirestoreServiceProtocol.self)
    let budgetRepository = DC.shared.resolve(type: .singleInstance, for: BudgetRepository.self)
    let addBudgetUseCase = DC.shared.resolve(type: .singleInstance, for: AddBudgetUseCaseProtocol.self)
    let authService = DC.shared.resolve(type: .singleInstance, for: AuthenticationServiceProtocol.self)

    let viewModel = HomeViewModel(firestoreService: firestoreService,
                                  budgetRepository: budgetRepository,
                                  addBudgetUseCase: addBudgetUseCase,
                                  authService: authService)

    let view = HomeView(viewModel: viewModel)
    let hostingVC = UIHostingController(rootView: view)
    return hostingVC
  }

}
