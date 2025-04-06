//
//  DeleteTransactionUseCase.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//


import Foundation

protocol DeleteTransactionUseCaseProtocol {
  func execute(transactionId: String, userId: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class DeleteTransactionUseCase {

  private let transactionRepository: TransactionRepository

  init(transactionRepository: TransactionRepository) {
    self.transactionRepository = transactionRepository
  }

}

// MARK: DeleteTransactionUseCaseProtocol
extension DeleteTransactionUseCase: DeleteTransactionUseCaseProtocol {

  func execute(transactionId: String, userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    transactionRepository.deleteTransaction(transactionId, for: userId, completion: completion)
  }

}
