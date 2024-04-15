import SwiftUI

struct SearchList: View {
    @Environment(\.dismiss) var dismiss
    @Binding var day: Day
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack{
            List(searchResults, id: \.self) { exercise in
                NavigationLink(destination: ExerciseDetail(day: $day, saveAction: saveAction, exercise: exercise)) {
                    HStack {
                        Text(exercise.name)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Exercises")
            .searchable(text: $searchText)
            
        }
     
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    var searchResults: [Exercise] {
        if searchText.isEmpty {
            return GymWiki
        } else {
            return GymWiki.filter { $0.name.contains(searchText) }
        }
    }
}

struct SearchList_Previews: PreviewProvider {
    static var previews: some View {
        SearchList(day: .constant(samplePlan.days[0]), saveAction: {})
    }
}

