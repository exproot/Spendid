//
//  FetchTransactionsUseCase.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//

import Foundation

protocol FetchTransactionsUseCaseProtocol {
  func execute(userId: String, completion: @escaping (Result<[Transaction], Error>) -> Void)
}

class FetchTransactionsUseCase {

  private let transactionRepository: TransactionRepository

  init(transactionRepository: TransactionRepository) {
    self.transactionRepository = transactionRepository
  }

}

// MARK: FetchTransactionsUseCaseProtocol
extension FetchTransactionsUseCase: FetchTransactionsUseCaseProtocol {

  func execute(userId: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
    transactionRepository.fetchTransactions(for: userId, completion: completion)
  }

}
