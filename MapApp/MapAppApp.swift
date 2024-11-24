//
//  MapAppApp.swift
//  MapApp
//
//  Created by Seher Ayesha on 18/05/2024.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
