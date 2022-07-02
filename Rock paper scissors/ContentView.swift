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
            Color.indigo
                .ignoresSafeArea()
            VStack (spacing: 40) {
                // score
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                // game table
                VStack {
                    Text(computerСhoice)
                    shouldDraw ?
                    Text("Draw")
                        .font(.title)
                    :
                    Text(shouldWin ? "You win" : "You lose")
                        .font(.title)
                    Text(userСhoice)
                }
                    .font(.system(size: 50))
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                // buttons
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button {
                            userСhoice = option
                            shouldWin = Bool.random()
                            shouldDraw = Int.random(in: 0...5) == 5
                            updateComputerChoice()
                        } label: {
                            Text(option)
                                .padding()
                                .background(.gray)
                                .font(.system(size: 50))
                        }
                    }
                }
            }
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
