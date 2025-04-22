//
//  DeleteBudgetUseCase.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//


import Foundation

protocol DeleteBudgetUseCaseProtocol {
  func execute(budgetId: String, userId: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class DeleteBudgetUseCase {

  private let budgetRepository: BudgetRepository

  init(budgetRepository: BudgetRepository) {
    self.budgetRepository = budgetRepository
  }

}

// MARK: DeleteBudgetUseCaseProtocol
extension DeleteBudgetUseCase: DeleteBudgetUseCaseProtocol {

  func execute(budgetId: String, userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    budgetRepository.deleteBudget(budgetId, for: userId, completion: completion)
  }

}
