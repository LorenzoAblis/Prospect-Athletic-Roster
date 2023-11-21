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
                Text(team.name)
            }
            Button(action: {
//                Task {
//                    await dataManager.addPlayer(teamID: "JMHCLm7UxFHD0rH04Emo", name: "Final Test", position: "asdasd", year: "Sophomore")
//                }
            }) {
                Text("asdasdasd")
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
