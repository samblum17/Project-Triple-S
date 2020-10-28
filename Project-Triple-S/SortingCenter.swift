//
//  SortingCenter.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//Gameplay view
struct SortingCenter: View {
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
                Image(getRandomUtensil())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
    
    //getRandomUtensil- Returns a new random utensil image each call
    func getRandomUtensil() -> String {
        let utensils: Set<String> = ["fork-shadow", "knife-shadow", "spoon-shadow"]
        //Below is always going to return a random element and never going to default to fork but, just for my own sanity, I dont want to force unwrap in such a seriously intense game. There's a lot at stake here
        return utensils.randomElement() ?? "fork"
    }
}

struct SortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SortingCenter()
    }
}
