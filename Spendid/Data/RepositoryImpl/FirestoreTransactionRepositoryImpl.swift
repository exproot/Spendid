//
//  FirestoreTransactionRepositoryImpl.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//


import Foundation

final class FirestoreTransactionRepositoryImpl {

  private let firestoreService: FirestoreServiceProtocol

  init(firestoreService: FirestoreServiceProtocol) {
    self.firestoreService = firestoreService
  }

}

// MARK: TransactionRepository
extension FirestoreTransactionRepositoryImpl: TransactionRepository {

  func fetchTransactions(for userId: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
    let path = "users/\(userId)/transactions"

    firestoreService.fetchCollection(path: path) { (result: Result<[TransactionDTO], Error>) in
      switch result {
      case .success(let transactionDTOs):
        let transactions = transactionDTOs.compactMap { $0.toDomain() }
        completion(.success(transactions))

      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func addTransaction(_ transaction: Transaction, for userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    let path = "users/\(userId)/transactions/\(transaction.id)"
    let dto = TransactionDTO(from: transaction)

    firestoreService.setDocument(path: path, data: dto, completion: completion)
  }

  func deleteTransaction(_ transactionId: String, for userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    let path = "users/\(userId)/transactions/\(transactionId)"

    firestoreService.deleteDocument(path: path, completion: completion)
  }

}
