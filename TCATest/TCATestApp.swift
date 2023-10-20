//
//  TCATestApp.swift
//  TCATest
//
//  Created by 柿崎逸 on 2023/10/20.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCATestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(initialState: Feature.State()) {
                    Feature()
                }
            )
        }
    }
}
