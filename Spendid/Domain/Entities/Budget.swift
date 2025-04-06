//
//  Budget.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//


import FirebaseFirestore

struct Budget: Identifiable {
  let id: String
  let title: String
  let totalAmount: Double
  let createdAt: Date
}
