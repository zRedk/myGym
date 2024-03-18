//
//  DayDetail.swift
//  MyFirstProject
//
//  Created by Federica Mosca on 27/04/23.
//

import SwiftUI

struct DayDetail: View {
    @Binding var day: Day
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    let dayIndex: Int
    
    var body: some View {
        NavigationStack {
            List(day.exercises, id: \.self) { data in
                NavigationLink(destination: ExerciseDetail(day: $day, saveAction: saveAction, exercise: data)) {
                    Text(data.name)
                }
            }
            .navigationTitle("Day \(dayIndex + 1)")
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct DayDetail_Previews: PreviewProvider {
    static var previews: some View {
        DayDetail(day: .constant(samplePlan.days[0]), saveAction: {}, dayIndex: 0)
    }
}
