//
// File: ContentView.swift
// Package: UtilityClassesTesting
// Created by: Steven Barnett on 12/05/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//
        

import SwiftUI
import UtilityClasses

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    
                    NavigationLink("Logging", destination: LoggingTests())
                    
                }
                
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
