//
//  Project_Triple_SApp.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//Main app entry
@main
struct Project_Triple_SApp: App {
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

    var body: some Scene {
        WindowGroup {
            if idiom == .pad {
            ContentView()
                .navigationViewStyle(StackNavigationViewStyle())
            } else {
            ContentView()
            }
        }
    }
}
