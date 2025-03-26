//
//  StartingSplashScreen.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/18/25.
//

import SwiftUI

struct StartingIntroFlow: View {
    
    // state variables to change current page
    @State private var textOffset: CGFloat = AppConstraints.titleTextOffset
    @State private var showButtons = false
    
    // button control variables
    @State private var showIntroFlow = false
    @State private var showChallenges = false
    
    var body: some View {
        ZStack {
            Color("cPink")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Debauchary Gamez")
                    .foregroundStyle(Color("cDark"))
                    .font(.system(size: 36, weight: .bold))
                    .padding()
                    .offset(y: textOffset) // offset the same as launch screen
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeInOut(duration: 1)) {
                                textOffset = -100
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    showButtons = true
                                }
                            }
                        }
                    }
                
                if showButtons {
                    VStack(spacing: 16) {
                        CustomButton(title: "Go To Challenges", buttonColor: Color("cPurple")) {
                            showChallenges = true
                        }
                        .fullScreenCover(isPresented: $showChallenges) {
                            //MapLiftView()
                            ChallengesView()
                        }
                        
                        CustomButton(title: "Introduction", buttonColor: Color("cOrange")) {
                            showIntroFlow = true
                        }
                        .fullScreenCover(isPresented: $showIntroFlow) {
                            TutorialFlowView()
                        }
                    }
                    .transition(.opacity)
                    .frame(maxWidth: .infinity)
                    
                }
            }
            Spacer()
        }
    }
}

// Custom Button Style
struct CustomButton: View {
    var title: String
    var buttonColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 30, weight: .medium)) // Twice as big text
                .frame(maxWidth: .infinity, minHeight: 60) // Equal width
                .foregroundColor(.white)
                .background(buttonColor)
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    StartingIntroFlow()
}
