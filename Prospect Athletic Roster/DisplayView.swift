//
//  DisplayView.swift
//  Prospect Athletic Roster
//
//  Created by Brock R. Wrede on 11/1/23.
//

import SwiftUI
import Firebase


struct DisplayView: View {
    @ObservedObject var dataManager = DataManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    Task {
                        await dataManager.fetchTeams()
                    }
                }) {
                    Text("Refresh")
                }
                Text("Teams")
                    .font(.headline)
                ForEach(dataManager.teams, id: \.self) { team in
                    NavigationLink(destination: TeamView(dataManager: dataManager, team: team.self)) {
                        Text(team.name)
                    }
                }
            }
        }
        .task {
            await dataManager.fetchTeams()
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
            .environmentObject(DataManager())
    }
}
