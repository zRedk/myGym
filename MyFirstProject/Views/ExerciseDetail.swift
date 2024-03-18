//
//  ExerciseDetail.swift
//  MyFirstProject
//
//  Created by Federica Mosca on 27/04/23.
//

import SwiftUI

struct ExerciseDetail: View {
    @Binding var day: Day
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) private var presentationMode
    let saveAction: () -> Void
    @State var exercise: Exercise
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    exercise.muscle.image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 500)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                Section(header: Text("configure your exercise")){
                    Stepper("Repetitions           \(exercise.reps)", value: $exercise.reps, in: 0...30)
                    Stepper("Series                    \(exercise.series)", value: $exercise.series, in: 0...30)
                    Stepper("Rest                       \(exercise.rest) s", value: $exercise.rest, in: 0...120, step: 10)
                }
                Section(header: Text("description")){
                    Text(exercise.description)
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: {
                        day.exercises.append(exercise)
                        presentationMode.wrappedValue.dismiss()
                    } ) {
                        Text("Save")
                    }
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ExerciseDetail_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetail(day: .constant(samplePlan.days[0]), saveAction: {}, exercise: Exercise(name: "Placeholder", muscle: .chest))
    }
}
