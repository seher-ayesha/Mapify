//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Seher Ayesha on 18/05/2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    //all loaded locations
    @Published var locations: [Location]
    
    //current location on map
    @Published var mapLocation: Location{
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //show list of locations
    @Published var showLocationsList: Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
    
        withAnimation(.easeOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationsList(){
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed(){
        // Get the current index
        
//        let currentIndex = locations.firstIndex {location in
//            return location == mapLocation
//        }
        
        // More efficient way
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print ("Could not find the current index in location array.")
            return
        }
        
        //check if the current index is valid. It will happen if the current index is the last item
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //next index is not valid
            //Restart from 0
            
            guard  let firstLocaton = locations.first else {return}
            showNextLocation(location: firstLocaton)
            return
        }
        
        //if the location does contain the index ie., next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
    }
}
