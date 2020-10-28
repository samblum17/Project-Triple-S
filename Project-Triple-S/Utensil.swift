//
//  Utensil.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//View of a single utensil
struct Utensil: View {
    @State var dragAmount = CGSize.zero
    @State var utensil: String = "fork-shadow"
    
    var body: some View {
        Image(self.utensil)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(dragAmount)
            .zIndex(dragAmount == .zero ? 0 : 1)
            .gesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                    }
                    .onEnded { _ in
                        self.dragAmount = .zero
                        self.utensil = getRandomUtensil()
                    }
                
            )
    }
    
    //getRandomUtensil- Returns a new random utensil image each call
    func getRandomUtensil() -> String {
        let utensils: Set<String> = ["fork-shadow", "knife-shadow", "spoon-shadow"]
        //Below is always going to return a random element and never going to default to fork but, just for my own sanity, I dont want to force unwrap in such a seriously intense game. There's a lot at stake here
        return utensils.randomElement() ?? "fork"
    }
}

struct Utensil_Previews: PreviewProvider {
    static var previews: some View {
        Utensil()
    }
}
