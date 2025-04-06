//
//  Transaction.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//

import FirebaseFirestore

struct Transaction: Identifiable {
  let id: String
  let budgetId: String
  let title: String
  let amount: Double
  let category: String
  let date: Date
}
