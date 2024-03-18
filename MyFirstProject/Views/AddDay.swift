//
//  AddDay.swift
//  MyFirstProject
//
//  Created by Federica Mosca on 26/04/23.
//

import SwiftUI

struct CustomBack: View {
    var label: String = "Exit"
    var action: ()->Void
    var type: Int
    
    var body: some View {
        
        Button(action: action) {
            if type == 1 {
                Image(systemName: "chevron.backward")
                    .renderingMode(.template)
                    .foregroundColor(.accentColor)
            }
            
            Text(label)
                .foregroundColor(.accentColor)
        }
    }
}

struct AddDay: View {
    @Binding var userPlan: Plan
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) private var presentationMode
    let saveAction: () -> Void
    @State var modalShown: Bool
    @State var currentDay: Day
    @State var actionSheet: Bool = false
    
    init(userPlan: Binding<Plan>, saveAction: @escaping () -> Void) {
        _userPlan = userPlan
        self.saveAction = saveAction
        _modalShown = State(initialValue: false)
        _currentDay = State(initialValue: Day( exercises: []))
    }
    
    var body: some View {
        NavigationStack{
            List(currentDay.exercises, id: \.self) { data in
                NavigationLink(destination: ExerciseDetail(day: $currentDay, saveAction: saveAction, exercise: data)) {
                    Text(data.name)
                }.contextMenu{
                    Button(role: .destructive,action:{
                        let index = currentDay.exercises.firstIndex(of: data)
                        currentDay.exercises.remove(at: index ?? 0)
                    }){
                        Text("Delete \(data.name)")
                    }
                }
            }
            .navigationTitle("Day \(userPlan.days.count + 1)")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    CustomBack(action: { actionSheet = true }, type: 1)
                        .confirmationDialog("If you exit all data will be lost", isPresented: $actionSheet, titleVisibility: .visible) {
                            Button(role: .destructive) {
                                actionSheet = false
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("I am sure, exit.")
                            }
                        }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: {
                        userPlan.days.append(currentDay)
                        presentationMode.wrappedValue.dismiss()
                    } ) {
                        Text("Save")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink(destination: SearchList(day: $currentDay, saveAction: saveAction)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct AddDay_Previews: PreviewProvider {
    static var previews: some View {
        AddDay(userPlan: .constant(samplePlan), saveAction: {})
    }
}
