//
//  FetchBudgetsUseCase.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//

import Foundation

protocol FetchBudgetsUseCaseProtocol {
  func execute(userId: String, completion: @escaping (Result<[Budget], Error>) -> Void)
}

class FetchBudgetsUseCase {

  private let budgetRepository: BudgetRepository

  init(budgetRepository: BudgetRepository) {
    self.budgetRepository = budgetRepository
  }

}

// MARK: FetchTransactionsUseCaseProtocol
extension FetchBudgetsUseCase: FetchBudgetsUseCaseProtocol {

  func execute(userId: String, completion: @escaping (Result<[Budget], Error>) -> Void) {
    budgetRepository.fetchBudgets(for: userId, completion: completion)
  }

}
