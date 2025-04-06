//
//  HomeViewModel.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//


import SwiftUI

class HomeViewModel: ObservableObject {

  @Published var testText: String = ""

  private let firestoreService: FirestoreServiceProtocol
  private let budgetRepository: BudgetRepository
  private let addBudgetUseCase: AddBudgetUseCaseProtocol
  private let authService: AuthenticationServiceProtocol

  init(firestoreService: FirestoreServiceProtocol,
       budgetRepository: BudgetRepository,
       addBudgetUseCase: AddBudgetUseCaseProtocol,
       authService: AuthenticationServiceProtocol)
  {
    self.firestoreService = firestoreService
    self.budgetRepository = budgetRepository
    self.addBudgetUseCase = addBudgetUseCase
    self.authService = authService
  }

  func onAppear() {
    testText = "Spendid"
  }

  func didTapSignOut() {
    authService.signOutCurrentUser { error in
      if let error {
        print(error.localizedDescription)
      }
    }
  }

}
