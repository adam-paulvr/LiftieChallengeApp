//
//  ChallengesView.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/24/25.
//

import SwiftUI

struct ChallengesView: View {
    
    // Get access to data controller
    let dataController = DataController.shared

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20){
                // Main Title Text
                Text("Gamez Page")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(dataController.getAllChallengeTypes(), id: \.self) { section in
                    SectionView(title: section)
                }
            }
            .padding()
        }
    }
}

struct SectionView: View {
    let title: String
    let items = [1] // example items
    // let items = dataController.getSectionItemsWithName(title) // something like this
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            //SidewaysScrollview
            ScrollView(.horizontal, showsIndicators: false) {
            
                // Programatically generate the liftie challenges
                HStack(spacing: 10) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: MapLiftView()){
                            ChallengeTile(imageName: "JHMRicon", text: "Jackson Hole")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

// MARK: - Challenge Tile Component
struct ChallengeTile: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image(imageName) // Top third as image
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 120, alignment: .center) // Adjust height for top third
                .clipped()
            
            Text(text) // Bottom two-thirds text
                .font(.headline)
                .foregroundColor(Color("cOrange"))
                .padding([.leading, .bottom], 8)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 150, height: 150) // Adjust to control tile size
        .background(Color("cTeal"))
        .cornerRadius(10)
    }
}

#Preview {
    ChallengesView()
}
