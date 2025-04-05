//
//  AuthenticationService.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import FirebaseAuth

protocol AuthenticationServiceProtocol {
  func signUp(with request: AuthRequest, completion: @escaping (Bool, Error?) -> Void)
  func signIn(with request: AuthRequest, completion: @escaping (Error?) -> Void)
  func signOutCurrentUser(completion: @escaping (Error?) -> Void)
}

final class AuthenticationService { }

// MARK: AuthenticationServiceProtocol
extension AuthenticationService: AuthenticationServiceProtocol {

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
    Auth.auth().createUser(withEmail: request.email, password: request.password) { authDataResult, error in
      if let error {
        completion(false, error)
        return
      }

      guard let authDataResult else {
        completion(false, nil)
        return
      }

      completion(true, nil)
      print(authDataResult.user)
      // TODO: Save User to the Firestore
    }
  }

}
