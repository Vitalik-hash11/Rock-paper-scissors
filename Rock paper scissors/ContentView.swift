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
    @State private var userСhoice = "📃"
    
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
                // table
                VStack {
                    Text("🪨")
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
                        } label: {
                            Text(option)
                                .padding()
                                .background(.gray)
                                .font(.system(size: 50))
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
