//
//  _name_App.swift
//  (name)
//
//  Created by Stoyan Nikolov on 9.05.24.
//

import SwiftUI

@main
struct HapvankaApp: App {
    private let menu = RecipesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(menu: menu)
        }
    }
}
