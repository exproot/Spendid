//
//  AuthenticationService.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

protocol AuthenticationServiceProtocol {
  func signUp(with request: AuthRequest, completion: @escaping (Bool, Error?) -> Void)
  func signIn(with request: AuthRequest, completion: @escaping (Error?) -> Void)
  func signOutCurrentUser(completion: @escaping (Error?) -> Void)
  func getCurrentUser() throws -> User
}

final class AuthenticationService {

  private let db = Firestore.firestore()

}

// MARK: AuthenticationServiceProtocol
extension AuthenticationService: AuthenticationServiceProtocol {

  func getCurrentUser() throws -> User {
    guard let user = Auth.auth().currentUser else { throw URLError(.badServerResponse) }

    return user
  }

  func signOutCurrentUser(completion: @escaping (Error?) -> Void) {
    do {
      try Auth.auth().signOut()
      completion(nil)
    } catch {
      completion(error)
    }
  }

  func signIn(with request: AuthRequest, completion: @escaping (Error?) -> Void) {
    Auth.auth().signIn(withEmail: request.email, password: request.password) { authDataResult, error in
      if let error {
        completion(error)
        return
      }

      completion(nil)
    }
  }

  func signUp(with request: AuthRequest, completion: @escaping (Bool, Error?) -> Void) {
    Auth.auth().createUser(withEmail: request.email, password: request.password) { [weak self] authDataResult, error in
      if let error {
        completion(false, error)
        return
      }

      guard let authDataResult else {
        completion(false, nil)
        return
      }

      let uid = authDataResult.user.uid
      let email = request.email
      let createdAt = Date()

      let firestoreUser = FirestoreUserDTO(uid: uid, email: email, createdAt: createdAt)

      self?.db.collection("users").document(uid).setData(firestoreUser.toDictionary()) { error in
        if let error {
          completion(false, error)
          return
        }

        completion(true, nil)
      }
    }
  }

}
