//
//  FavouriteNumberView.swift
//  HMS-Team 5
//
//  Created by user1 on 23/04/24.
//

import SwiftUI
import Combine
import FirebaseAnalytics
import FirebaseAnalyticsSwift

class FavouriteNumberViewModel: ObservableObject {
  @Published var favouriteNumber: Int = 42

  private var defaults = UserDefaults.standard
  private let favouriteNumberKey = "favouriteNumber"
  private var cancellables = Set<AnyCancellable>()

  init() {
    if let number = defaults.object(forKey: favouriteNumberKey) as? Int {
      favouriteNumber = number
    }
    $favouriteNumber
      .sink { number in
        self.defaults.set(number, forKey: self.favouriteNumberKey)
        Analytics.logEvent("stepper", parameters: ["value" : number])
      }
      .store(in: &cancellables)
  }
}

struct FavouriteNumberView: View {
  @StateObject var viewModel = FavouriteNumberViewModel()
  var body: some View {
    VStack {
      Text("What's your favourite number?")
        .font(.title)
        .multilineTextAlignment(.center)
      Spacer()
        
      Stepper(value: $viewModel.favouriteNumber, in: 0...100) {
        Text("\(viewModel.favouriteNumber)")
      }
    }
    .frame(maxHeight: 150)
    .foregroundColor(.white)
    .padding()
    #if os(iOS)
    .background(Color(UIColor.lightGray))
    #endif
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding()
    .shadow(radius: 8)
    .navigationTitle("Favourite Number")
    .analyticsScreen(name: "\(FavouriteNumberView.self)")
  }
}

struct FavouriteNumberView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FavouriteNumberView()
    }
  }
}
