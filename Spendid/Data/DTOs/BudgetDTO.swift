//
//  BudgetDTO.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//

import FirebaseFirestore

struct BudgetDTO: Codable {
  let id: String
  let title: String
  let totalAmount: Double
  let createdAt: Date

  init(from entity: Budget) {
    self.id = entity.id
    self.title = entity.title
    self.totalAmount = entity.totalAmount
    self.createdAt = entity.createdAt
  }

}

extension BudgetDTO {
  func toDomain() -> Budget {
    return Budget(
      id: id,
      title: title,
      totalAmount: totalAmount,
      createdAt: createdAt)
  }
}
