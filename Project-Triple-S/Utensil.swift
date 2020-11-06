//
//  Utensil.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//View for a single utensil
struct Utensil: View, Hashable {
    //General utensil properties
    var utensil: String
    var id = UUID()
    
    //Binded to the SortingCenter for gameplay
    @Binding var forkScore: Int
    @Binding var knifeScore: Int
    @Binding var spoonScore: Int
    @Binding var totalScore: Int
    @Binding var drawerFrames: [CGRect]
    @Binding var drawerOrigins: [CGPoint]
    
    //Current utensil's properties
    @State private var dragAmount = CGSize.zero
    @State private var dragState = DragState.unknown
    @State var dropped: Bool = false
    @State private var endPos = CGPoint.zero
    var onChanged: ((CGPoint, String) -> DragState)?
    var onEnded: ((CGPoint, String) -> CGPoint)?
    
    //For readability
    static let fork = "fork-shadow"
    static let knife = "knife-shadow"
    static let spoon = "spoon-shadow"
    
    //Needed for survivor mode
    @AppStorage("survivorMode", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorMode: Bool = false
    @Binding var gameTimer: GameTimer
    @Binding var timeRemaining: Int
    @Binding var gameOverShowing: Bool
    
    //One utensil
    var body: some View {
        Image(self.utensil)
            .resizable()
            .offset(dragAmount)
            .if(dropped){value in value.position(endPos)}
            .scaledToFill()
            .zIndex(dragAmount == .zero ? 0 : 1)
            .shadow(color: Color.black, radius: dropped ? 2 : 0)
            .gesture (
                DragGesture(coordinateSpace: .global)
                    //While dragging, update the offset and state of drag
                    .onChanged {
                        self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                        self.dragState = self.onChanged?($0.location, self.utensil) ?? .unknown
                    }
                    //When dropped, check if valid, send haptic feedback, increase scores, set correct drawer position
                    .onEnded { value in
                        if dragState == .good {
                            successHapticFeedback()
                            if survivorMode {
                                gameTimer.cancelTimer()
                                gameTimer.instantiateTimer(timeRemaining: 1)
                                timeRemaining = 1
                            }
                            endPos = self.onEnded?(value.location, self.utensil) ?? CGPoint.zero
                            let drawerWidth = -drawerFrames[0].width //for readability
                            let drawerHeight = -drawerFrames[0].height //for readability
                            switch self.utensil {
                            case Utensil.fork:
                                self.dragAmount = CGSize(width: drawerWidth, height: drawerHeight)
                                forkScore += 1
                                dropped = true
                            case Utensil.knife:
                                self.dragAmount = CGSize(width: drawerWidth, height: drawerHeight)
                                knifeScore += 1
                                dropped = true
                            case Utensil.spoon:
                                self.dragAmount = CGSize(width: drawerWidth, height: drawerHeight)
                                spoonScore += 1
                                dropped = true
                            default:
                                break
                            }
                        } else {
                            if survivorMode {
                                failureHapticFeedback()
                                gameOverShowing = true
                                gameTimer.cancelTimer()
                            } else {
                            withAnimation(.spring()) {
                                failureHapticFeedback()
                                self.dragAmount = .zero
                            }
                            }
                        }
                    }
            )
            .allowsHitTesting(!dropped) //Disable dragging once dropped
    }
    
    
    //Helper functions for providing haptic feedback
    func successHapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func failureHapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    //Conformance to hashable for iterating over array of unsorted utensils
    static func == (lhs: Utensil, rhs: Utensil) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

//Manage state of current utensil's drop site
enum DragState {
    case unknown
    case good
    case bad
}

//Extension for conditional modifiers on the view
extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
