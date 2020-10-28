//
//  SortingCenter.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//Gameplay view
struct SortingCenter: View {
    @Binding var highScore: Int
    var body: some View {
        VStack {
            HStack(spacing: 100) {
                Text("0").font(.title2)
                Text("0").font(.title2)
                Text("0").font(.title2)
            }.padding()
            Image("drawer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.horizontal)
            HStack {
                Utensil(dragAmount: CGSize.zero, utensil: "fork-shadow")
                ZStack{
                    Image("plate")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("0:17")
                        .font(.title)
                        .foregroundColor(.yellow)
                }
            }
        }.edgesIgnoringSafeArea(.horizontal)
    }
    
   
}

struct SortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SortingCenter(highScore: .constant(100))
    }
}
