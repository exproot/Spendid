//
//  AddTransactionUseCase.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//


import Foundation

protocol AddTransactionUseCaseProtocol {
  func execute(transaction: Transaction, userId: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class AddTransactionUseCase {

  private let transactionRepository: TransactionRepository

  init(transactionRepository: TransactionRepository) {
    self.transactionRepository = transactionRepository
  }

}

// MARK: AddTransactionUseCaseProtocol
extension AddTransactionUseCase: AddTransactionUseCaseProtocol {

  func execute(transaction: Transaction, userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    transactionRepository.addTransaction(transaction, for: userId, completion: completion)
  }

}
