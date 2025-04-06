//
//  TransactionDTO.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//


import FirebaseFirestore

struct TransactionDTO: Codable {
  let id: String
  let budgetId: String
  let title: String
  let amount: Double
  let date: Date
  let category: String

  init(from entity: Transaction) {
    id = entity.id
    budgetId = entity.budgetId
    title = entity.title
    amount = entity.amount
    category = entity.category
    date = entity.date
  }
}

extension TransactionDTO {
  func toDomain() -> Transaction {
    return Transaction(
      id: id,
      budgetId: budgetId,
      title: title,
      amount: amount,
      category: category,
      date: date)
  }
}
