//
//  FirestoreBudgetRepositoryImpl.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//

import Foundation

final class FirestoreBudgetRepositoryImpl {

  private let firestoreService: FirestoreServiceProtocol

  init(firestoreService: FirestoreServiceProtocol) {
    self.firestoreService = firestoreService
  }

}

// MARK: BudgetRepository
extension FirestoreBudgetRepositoryImpl: BudgetRepository {

  func fetchBudgets(for userId: String, completion: @escaping (Result<[Budget], Error>) -> Void) {
    let path = "users/\(userId)/budgets"

    firestoreService.fetchCollection(path: path) { (result: Result<[BudgetDTO], Error>) in
      switch result {
      case .success(let budgetDTOs):
        let budgets = budgetDTOs.compactMap { $0.toDomain() }
        completion(.success(budgets))

      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func addBudget(_ budget: Budget, for userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    let path = "users/\(userId)/budgets/\(budget.id)"
    let dto = BudgetDTO(from: budget)

    firestoreService.setDocument(path: path, data: dto, completion: completion)
  }
  
  func deleteBudget(_ budgetId: String, for userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    let path = "users/\(userId)/budgets/\(budgetId)"

    firestoreService.deleteDocument(path: path, completion: completion)
  }
  
}
