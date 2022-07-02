//
//  ContentView.swift
//  Rock paper scissors
//
//  Created by newbie on 01.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var userСhoice = " "
    @State private var computerСhoice = "✂️"
    @State private var shouldDraw = Int.random(in: 0...5) == 5
    @State private var gameCount = 0
    @State private var showFinalAlert = false
    
    private let options = ["✂️", "📃", "🪨"]
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color(red: 0.23, green: 0.46, blue: 0.38), Color(red: 0.07, green: 0.25, blue: 0.65)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack (spacing: 40) {
                Spacer()
                // score
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                Spacer()
                // game table
                VStack {
                    Text(computerСhoice)
                        .padding()
                    shouldDraw ?
                    Text("Draw")
                        .font(.title)
                    :
                    Text(shouldWin ? "You win" : "You lose")
                        .font(.title)
                    Text(userСhoice)
                        .padding()
                }
                    .font(.system(size: 50))
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Spacer()
                // buttons
                HStack (spacing: 15) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            userСhoice = option
                            shouldWin = Bool.random()
                            shouldDraw = Int.random(in: 0...5) == 5
                            updateComputerChoice()
                        } label: {
                            Text(option)
                                .padding()
                                .shadow(radius: 20)
                                .background(Color(red: 0.20, green: 0.20, blue: 0.20, opacity: 0.5))
                                .font(.system(size: 50))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
                Spacer()
            }
                .padding()
        } .alert("Your final score: \(score)", isPresented: $showFinalAlert) {
            Button("Continue") {
                gameCount = 0
            }
            Button("Restart") {
                score = 0
                gameCount = 0
            }
        }
    }
    
    private func updateComputerChoice() {
        gameCount += 1
        if gameCount == 5 {
            showFinalAlert = true
        }
        switch userСhoice {
        case "📃":
            computerСhoice = shouldWin ? "🪨" : "✂️"
        case "🪨":
            computerСhoice = shouldWin ? "✂️" : "📃"
        case "✂️":
            computerСhoice = shouldWin ? "📃" : "🪨"
        default:
            fatalError("Unknown choice")
        }
        if shouldDraw {
            computerСhoice = userСhoice
        }
        if computerСhoice != userСhoice && shouldWin {
            score += 1
        } else if computerСhoice != userСhoice && !shouldWin {
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
