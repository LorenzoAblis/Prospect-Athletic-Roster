//
//  AddAthleteView.swift
//  Prospect Athletic Roster
//
//  Created by Lorenzo J. Ablis on 11/1/23.
//

import SwiftUI

struct AddAthleteView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var teamName = ""
    @State private var teamSeason = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                ForEach(dataManager.teams, id: \.id) { team in
                    NavigationLink(destination: TeamView(teamID: team.id, name: team.name, season: team.season, coaches: team.coaches, players: team.players)) {
                        Text(team.name)
                    }
                }
                
                TextField("Name", text: $teamName)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: {
                    Task {
                        try await dataManager.addTeam(name: teamName, season: teamSeason)
                    }
                }) {
                    Text("Add Team")
                }
            }
        }.task {
            Task {
                try await dataManager.fetchTeams()
            }
        }
    }
}

#Preview {
    AddAthleteView()
        .environmentObject(DataManager())
}
