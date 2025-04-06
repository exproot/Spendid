//
//  BudgetRepository.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//

import Foundation

protocol BudgetRepository {
  func fetchBudgets(for userId: String, completion: @escaping (Result<[Budget], Error>) -> Void)
  func addBudget(_ budget: Budget, for userId: String, completion: @escaping (Result<Void, Error>) -> Void)
  func deleteBudget(_ budgetId: String, for userId: String, completion: @escaping (Result<Void, Error>) -> Void)
}
