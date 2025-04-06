//
//  FirestoreUserDTO.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//

import Foundation

struct FirestoreUserDTO: Codable {
  let uid: String
  let email: String
  let fullName: String?
  let createdAt: Date

  init(uid: String, email: String, fullName: String? = nil, createdAt: Date) {
    self.uid = uid
    self.email = email
    self.fullName = fullName
    self.createdAt = createdAt
  }

  func toDictionary() -> [String: Any] {
    return [
      "uid": uid,
      "email": email,
      "fullName": fullName ?? "",
      "createdAt": createdAt
    ]
  }
}
