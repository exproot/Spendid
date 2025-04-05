//
//  SceneDelegate.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import FirebaseAuth
import UIKit

enum AuthState {
  case signedIn, signedOut
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  var authHandle: AuthStateDidChangeListenerHandle?
  let navigationController = AppNavigationControllerProvider.makeNavigationController()

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)

    checkAuthenticationState { [weak self] authState in
      guard let self = self else { return }

      switch authState {
      case .signedIn:
        DispatchQueue.main.async {
          self.setHomeController(with: window)
        }
      case .signedOut:
        DispatchQueue.main.async {
          self.setSignInController(with: window)
        }
      }
    }
  }

  func checkAuthenticationState(completion: @escaping (AuthState) -> Void) {
    authHandle = Auth.auth().addStateDidChangeListener { _, user in
      if let user {
        print(Thread.current)
        print("Auth state changed to signed in: \(user)")
        completion(.signedIn)
      } else {
        print(Thread.current)
        print("Auth state changed, to signed out")
        completion(.signedOut)
      }
    }
  }

  func setSignInController(with window: UIWindow) {
    let signInCoordinator = SignInCoordinator(navigationController: navigationController)
    let signInVC = signInCoordinator.makeViewController()

    navigationController.setViewControllers([signInVC], animated: false)

    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
  }

  func setHomeController(with window: UIWindow) {
    let homeCoordinator = HomeCoordinator(navigationController: navigationController)
    let homeVC = homeCoordinator.makeViewController()

    navigationController.setViewControllers([homeVC], animated: false)

    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
  }

}

