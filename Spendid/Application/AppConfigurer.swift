//
//  AppConfigurer.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import DependencyContainer
import Foundation

enum AppConfigurer {
  
  private static var didConfigureDependencies = false
  
  static func configureDependencies() {
    guard didConfigureDependencies == false else {
      assertionFailure("")
      return
    }
    
    didConfigureDependencies = true
    
    // MARK: Dependency Registrations
    DC.shared.register(type: .singleInstance(AuthenticationService()), for: AuthenticationServiceProtocol.self)
    DC.shared.register(type: .singleInstance(FirestoreService()), for: FirestoreServiceProtocol.self)

    DC.shared.register(type: .singleInstance(
      FirestoreBudgetRepositoryImpl(
        firestoreService: DC.shared.resolve(type: .singleInstance, for: FirestoreServiceProtocol.self)
      )
    ), for: BudgetRepository.self)

    DC.shared.register(type: .singleInstance(
      AddBudgetUseCase(
        budgetRepository: DC.shared.resolve(type: .singleInstance, for: BudgetRepository.self)
      )
    ), for: AddBudgetUseCaseProtocol.self)
  }
  
}
