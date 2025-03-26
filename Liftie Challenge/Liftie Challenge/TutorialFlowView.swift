//
//  TutorialFlowView.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/24/25.
//

import SwiftUI

struct TutorialFlowView: View {
    @State private var showChallenges = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Spacer()
        
        Button("Go To Challenges"){
            showChallenges = true
        }
        .fullScreenCover(isPresented: $showChallenges){
            //MapLiftView()
            ChallengesView()
        }
    }
}

#Preview {
    TutorialFlowView()
}
