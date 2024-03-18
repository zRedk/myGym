//
//  DayBox.swift
//  MyFirstProject
//
//  Created by Federica Mosca on 22/04/23.
//

import SwiftUI

struct DayBox: View {
    let index: Int
    let data: Day
    
    var body: some View {
        Image("\(index)")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: 360)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(LinearGradient(colors: [ Color(hue: 1.0, saturation: 0.0, brightness: 0.1), .clear], startPoint: .bottom, endPoint: .top))
                    
                    VStack {
                        Spacer().frame(maxHeight: 20.0)
                        RoundedRectangle(cornerRadius: 60.0)
                            .frame(maxWidth: 90, maxHeight: 30.0)
                            .foregroundColor(Color(hue: 0.0, saturation: 0.002, brightness: 0.685, opacity: 0.864))
                            .overlay(
                                Text("Day \(index)").foregroundColor(.black)
                            )
                        Spacer()
                    }.shadow(color: .black, radius: 10.0)
                }
            )
            .shadow(radius: 5)
    }
}

struct DayBox_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(userPlan: .constant(samplePlan), saveAction: {})
    }
}
