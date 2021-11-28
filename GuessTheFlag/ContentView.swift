//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by aeglus on 2021/11/28.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Button("Show Alert") {
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please read this.")
            }
            Button("Button 1") { }
            .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
            .buttonStyle(.bordered)
            Button("Button 3") { }
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            Button("Button 4", role: .destructive) { }
            .buttonStyle(.borderedProminent)
            Button {
                print("Edit button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .buttonStyle(.bordered)
        }
        Button {
            print("Button was tapped")
        } label: {
            Text("Tap me!")
                .padding()
                .foregroundColor(.white)
                .background(.red)
        }
    }
    
    func executeDelete() {
        print("Now deleting...")
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
