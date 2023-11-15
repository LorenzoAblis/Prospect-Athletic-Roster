//
//  DisplayView.swift
//  Prospect Athletic Roster
//
//  Created by Brock R. Wrede on 11/1/23.
//

import SwiftUI
import Firebase

struct DisplayView: View {
    
    @ObservedObject var model = DataManager()
    
    
    
    var body: some View {
        
        //        List (model.teama) {item in
        //            Text(item)
        //
        NavigationView {
            VStack {
                Text("Teams")
                    .font(.headline)
                ForEach(model.teams, id: \.self) { team in
                    
//                    Text(team.name)
                    NavigationLink(destination: TeamView(teamID: team.id)) {
                        Text(team.name)
                    }
                    
                }
                
                
                
            }
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
        
        
        
    }
}
