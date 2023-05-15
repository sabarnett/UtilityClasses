//
// File: LoggingTests.swift
// Package: UtilityClassesTesting
// Created by: Steven Barnett on 15/05/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//
        
import SwiftUI
import UtilityClasses

struct LoggingTests: View {
    
    @State var loggingEnabled: Bool = true
    
    var body: some View {
        VStack {
            Button(action: {
                print("-----------------> Log messages")
                WriteLog.error("This is an ERROR message")
                WriteLog.warning("This is a WARNING message")
                WriteLog.success("This is a SUCCESS message")
                WriteLog.info("This is an INFO message")
                WriteLog.network("This is a NETWORK message")
                WriteLog.debug("This is a DEBUG message")
            }, label: {
                Text("Write Log Messages")
            })
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            
            List {
                Section("Enabled") {
                    Toggle(isOn: $loggingEnabled,
                           label: { Text("logging enabled")})
                }
                
                Section("Types logged") {
                    LoggingTypesToggle()
                }
            }
            Spacer()
        }.onChange(of: loggingEnabled, perform: { _ in
            if loggingEnabled {
                WriteLog.startLogging()
                WriteLog.info("Logging Started")
            } else {
                WriteLog.info("Logging stopped.")
                WriteLog.stopLogging()
            }
        })
        .onAppear {
            // Set the initial state to match the form state
            WriteLog.startLogging(all: true)
        }
        .padding()
    }
}

struct LoggingTypesToggle: View {
    
    @State var errorEnabled: Bool = true
    @State var warningEnabled: Bool = true
    @State var successEnabled: Bool = true
    @State var infoEnabled: Bool = true
    @State var networkEnabled: Bool = true
    @State var debugEnabled: Bool = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $errorEnabled, label: { Text("Errors")})
            Toggle(isOn: $warningEnabled, label: { Text("Warnings")})
            Toggle(isOn: $successEnabled, label: { Text("Success")})
            Toggle(isOn: $infoEnabled, label: { Text("Info")})
            Toggle(isOn: $networkEnabled, label: { Text("Network")})
            Toggle(isOn: $debugEnabled, label: { Text("Debug")})
        }
        .onChange(of: errorEnabled, perform: { newState in
            if newState { WriteLog.addLogLevel(.error) }
            else { WriteLog.removeLogLevel(.error) }
        })
        .onChange(of: warningEnabled, perform: { newState in
            if newState { WriteLog.addLogLevel(.warning) }
            else { WriteLog.removeLogLevel(.warning) }
        })
        .onChange(of: successEnabled, perform: { newState in
            if newState { WriteLog.addLogLevel(.success) }
            else { WriteLog.removeLogLevel(.success) }
        })
        .onChange(of: infoEnabled, perform: { newState in
            if newState { WriteLog.addLogLevel(.info) }
            else { WriteLog.removeLogLevel(.info) }
        })
        .onChange(of: networkEnabled, perform: { newState in
            if newState { WriteLog.addLogLevel(.network) }
            else { WriteLog.removeLogLevel(.network) }
        })
        .onChange(of: debugEnabled, perform: { newState in
            if newState { WriteLog.addLogLevel(.debug) }
            else { WriteLog.removeLogLevel(.debug) }
        })
    }
}

struct LoggingTests_Previews: PreviewProvider {
    static var previews: some View {
        LoggingTests()
    }
}
