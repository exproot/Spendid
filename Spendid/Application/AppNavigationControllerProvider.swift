//
//  AppNavigationControllerProvider.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import UIKit

enum AppNavigationControllerProvider {

  static func makeNavigationController() -> UINavigationController {
    let navVC = UINavigationController()

    navVC.navigationBar.prefersLargeTitles = true
    return navVC
  }

}
