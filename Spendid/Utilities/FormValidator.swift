//
//  FormValidator.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//


import Combine
import SwiftUI

enum FormValidator {
  static func validateEmail(_ email: String) -> Bool {
    let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
    return emailPredicate.evaluate(with: email)
  }

  static func validatePassword(_ password: String) -> Bool {
    // least one uppercase,
    // least one digit
    // least one lowercase
    // least one symbol
    //  min 8 characters
    let password = password.trimmingCharacters(in: CharacterSet.whitespaces)
    let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%.^&<>*~:`-]).{8,}$"
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return passwordPredicate.evaluate(with: password)
  }
}