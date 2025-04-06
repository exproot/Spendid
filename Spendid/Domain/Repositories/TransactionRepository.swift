//
//  TransactionRepository.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//


import Foundation

protocol TransactionRepository {
  func fetchTransactions(for userId: String, completion: @escaping (Result<[Transaction], Error>) -> Void)
  func addTransaction(_ transaction: Transaction, for userId: String, completion: @escaping (Result<Void, Error>) -> Void)
  func deleteTransaction(_ transactionId: String, for userId: String, completion: @escaping (Result<Void, Error>) -> Void)
}
