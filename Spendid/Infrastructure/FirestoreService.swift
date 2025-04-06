//
//  FirestoreService.swift
//  Spendid
//
//  Created by Ertan Yağmur on 6.04.2025.
//

import FirebaseFirestore

protocol FirestoreServiceProtocol {
  func fetchCollection<T: Decodable>(path: String, completion: @escaping (Result<[T], Error>) -> Void)
  func setDocument<T: Encodable>(path: String, data: T, completion: @escaping (Result<Void, Error>) -> Void)
  func addDocument<T: Encodable>(path: String, data: T, completion: @escaping (Error?) -> Void)
  func deleteDocument(path: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class FirestoreService: FirestoreServiceProtocol {

  private let db = Firestore.firestore()

  func fetchCollection<T>(path: String, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
    db.collection(path).getDocuments { snapshot, error in
      if let error {
        completion(.failure(error))
        return
      }

      guard let documents = snapshot?.documents else {
        completion(.failure(URLError(.badURL)))
        return
      }

      let items: [T] = documents.compactMap {
        try? $0.data(as: T.self)
      }

      completion(.success(items))
    }
  }

  func setDocument<T>(path: String, data: T, completion: @escaping (Result<Void, Error>) -> Void) where T : Encodable {
    do {
      try db.document(path).setData(from: data) { error in
        if let error {
          completion(.failure(error))
        } else {
          completion(.success(()))
        }
      }
    } catch {
      completion(.failure(error))
    }
  }

  func addDocument<T>(path: String, data: T, completion: @escaping (Error?) -> Void) where T : Encodable {
    do {
      try db.collection(path).addDocument(from: data) { error in
        if let error {
          completion(error)
        } else {
          completion(nil)
        }
      }
    } catch {
      completion(error)
    }
  }

  func deleteDocument(path: String, completion: @escaping (Result<Void, Error>) -> Void) {
    db.document(path).delete { error in
      if let error {
        completion(.failure(error))
      } else {
        completion(.success(()))
      }
    }
  }

}
