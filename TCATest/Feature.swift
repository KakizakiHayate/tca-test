//
//  Feature.swift
//  TCATest
//
//  Created by 柿崎逸 on 2023/10/20.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct Feature: Reducer {
  struct State: Equatable {
    var count = 0
    var numberFactAlert: String?
  }
    enum Action: Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
      }
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .factAlertDismissed:
          state.numberFactAlert = nil
          return .none // 何もする必要がない・何も返さない

        case .decrementButtonTapped:
          state.count -= 1
          return .none

        case .incrementButtonTapped:
          state.count += 1
          return .none

        case .numberFactButtonTapped:
          return .run { [count = state.count] send in
            let (data, _) = try await URLSession.shared.data(
              from: URL(string: "http://numbersapi.com/\(count)/trivia")!
            )
            await send(
              .numberFactResponse(String(decoding: data, as: UTF8.self))
            )
          }

        case let .numberFactResponse(fact):
          state.numberFactAlert = fact
          return .none
        }
      }
}

