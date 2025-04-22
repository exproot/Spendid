//
//  HomeView.swift
//  Spendid
//
//  Created by Ertan Yağmur on 5.04.2025.
//

import SwiftUI

struct HomeView: View {

  @ObservedObject var viewModel: HomeViewModel

  var body: some View {

    VStack {
      Text(viewModel.testText)
        .bold()
        .font(.title3)
        .onAppear {
          viewModel.onAppear()
        }

      Button {
        viewModel.didTapSignOut()
      } label: {
        Text("Sign Out")
      }
    }
    .navigationTitle("Home")


  }

}

//#Preview {
//  HomeView(viewModel: HomeViewModel(authService: AuthenticationService()))
//}
