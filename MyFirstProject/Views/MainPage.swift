//
//  ContentView.swift
//
//  Created by Federica Mosca on 20/04/23.
//

import SwiftUI

struct MainPage: View {
    @Binding var userPlan: Plan
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                LazyVStack{
                    
                    VStack {
                        HStack {
                           
                            Spacer()
                            
                            Text("Starting date")
                                .foregroundColor(.gray)
                            
                            Spacer().frame(maxWidth: 45.0)
                            
                            Text("Ending date")
                                .foregroundColor(.gray)
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical, -5.0)
                        
                        HStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .frame(maxWidth: 80, minHeight: 30.0)
                                .foregroundColor(Color(hue: 0.0, saturation: 0.002, brightness: 0.685, opacity: 0.4))
                                .overlay(
                                    Text(checkValid(endDate: userPlan.endDate) == true ? "Expired":"In use")
                                        .fontWeight(.heavy)
                                        .foregroundColor(checkValid(endDate: userPlan.endDate) == true ? Color(hue: 1.0, saturation: 1.0, brightness: 0.762):Color(hue: 0.432, saturation: 1.0, brightness: 0.511))
                                )
                            
                            Spacer()
                            
                            
                            DatePicker(selection: $userPlan.startDate, in: Date.now..., displayedComponents: .date) {
                            }
                            
                            DatePicker(selection: $userPlan.endDate, in: userPlan.startDate..., displayedComponents: .date) {
                            }
                        }
                    }
                    
                    ForEach(Array(userPlan.days.enumerated()), id: \.offset) { index, data in
                        
                        NavigationLink(destination: DayDetail(day: $userPlan.days[index], saveAction: saveAction, dayIndex: index)) {
                            DayBox(index: index + 1, data: data)
                                
                        }.contextMenu{
                            Button(role: .destructive,action:{
                                let index = userPlan.days.firstIndex(of: data)
                                userPlan.days.remove(at: index ?? 0)
                            }){
                                Text("Delete workout day")
                            }
                        }
                    }
                }.padding(.horizontal)
            }
            .navigationTitle("Workout Plan")
            .toolbar {
                if userPlan.days.count < 7 {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddDay(userPlan: $userPlan, saveAction: saveAction).navigationBarBackButtonHidden(true)) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    func checkValid(endDate: Date) -> Bool {
        if endDate.timeIntervalSince1970 <= userPlan.startDate.timeIntervalSince1970 {
            return true
        }
        
        return false
    }
    
}
    


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(userPlan: .constant(samplePlan), saveAction: {})
    }
}

