//
// File: UtilityClassesTestingApp.swift
// Package: UtilityClassesTesting
// Created by: Steven Barnett on 12/05/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//
        

import SwiftUI
import UtilityClasses

@main
struct UtilityClassesTestingApp: App {
    
    init() {
        WriteLog.info("Starting the test app.")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
