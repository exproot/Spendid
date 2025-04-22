//
//  AddBudgetUseCase.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//


import Foundation

protocol AddBudgetUseCaseProtocol {
  func execute(budget: Budget, userId: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class AddBudgetUseCase {

  private let budgetRepository: BudgetRepository

  init(budgetRepository: BudgetRepository) {
    self.budgetRepository = budgetRepository
  }

}

// MARK: AddBudgetUseCaseProtocol
extension AddBudgetUseCase: AddBudgetUseCaseProtocol {

  func execute(budget: Budget, userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    budgetRepository.addBudget(budget, for: userId, completion: completion)
  }

}
