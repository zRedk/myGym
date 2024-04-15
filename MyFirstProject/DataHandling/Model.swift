import Foundation
import SwiftUI

enum MuscularType: Codable {
case chest, back, shoulders, biceps, triceps, quads, glutes, hamstrings, calves, abdominals
    
    var image: Image {
           switch self {
           case .chest: return Image("chest")
               case .back: return Image("back")
               case .shoulders: return Image("shoulders")
               case .biceps: return Image("biceps")
               case .triceps: return Image("triceps")
               case .quads: return Image("quads")
               case .glutes: return Image("glutes")
               case .hamstrings: return Image("hamstrings")
               case .calves: return Image("calves")
               case .abdominals: return Image("abdominals")
           }
       }

       var color: Color {
           switch self {
               case .chest: return Color.green
               case .back: return Color.teal
               case .shoulders: return Color.mint
               case .biceps: return Color.cyan
               case .triceps: return Color.indigo
               case .quads: return Color.red
               case .glutes: return Color.orange
               case .hamstrings: return Color.yellow
               case .calves: return Color.purple
               case .abdominals: return Color.pink
           }
       }
    
}

struct Exercise: Identifiable, Codable, Hashable {
    var id = UUID()
    let name: String
    var series: Int = 0
    var reps: Int = 0
    var rest: Int = 0
    let muscle: MuscularType
    var description: String = "No description available"
}

struct Day: Identifiable, Codable, Hashable {
    var id = UUID()
    var exercises: [Exercise]
}

struct Plan: Codable{
    var startDate: Date = Date.now
    var endDate: Date = Date.now
    var days: [Day] = []
}

extension Plan {
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: date)
    }
}
