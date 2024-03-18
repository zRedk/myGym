//
//  Data.swift
//  FoundationApp
//
//  Created by Federica Mosca on 22/04/23.
//

import SwiftUI

var samplePlan: Plan = Plan(days: [
    Day( exercises: []),
    Day( exercises: []),
    Day( exercises: [])
])

@MainActor
class DataStore: ObservableObject {
    @Published var userPlan: Plan = Plan()
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("gym.data")
    }
    
    func load() async throws {
        let task = Task<Plan, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return Plan(days: [])
            }
            let userPlan = try JSONDecoder().decode(Plan.self, from: data)
            return userPlan
        }

        let plan = try await task.value
        self.userPlan = plan
    }
    
    func save(plan: Plan) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(plan)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
