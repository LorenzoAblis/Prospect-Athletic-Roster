//
//  ContentView.swift
//  Prospect Athletic Roster
//
//  Created by Lorenzo J. Ablis on 10/24/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack {
            ForEach(dataManager.teams, id: \.self) { team in
                ForEach(team.coaches, id: \.self) { coach in
                    Text("Coach: \(coach.name)")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataManager())
    }
}
