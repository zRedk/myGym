//
//  MyFirstProjectApp.swift
//  MyFirstProject
//
//  Created by Giovanni Monaco on 05/10/22.
//

import SwiftUI

@main
struct MyFirstProjectApp: App {
    @StateObject var sharedData = DataStore()
    
    var body: some Scene {
        WindowGroup {
            MainPage(userPlan: $sharedData.userPlan, saveAction: {
                Task {
                    do {
                        try await sharedData.save(plan: sharedData.userPlan)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            })
                .task {
                    do {
                        try await sharedData.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
