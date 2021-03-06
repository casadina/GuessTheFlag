//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by aeglus on 2021/11/28.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany",
                                    "Ireland", "Italy", "Nigeria",
                                    "Poland", "Russia", "Spain",
                                    "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var round = 1
    @State private var gameOver = false
    @State private var animationAmount = 0.0
    @State private var correctFlag = false
    
    struct CapsuleFlag: View {
        var image: String
        
        var body: some View {
            Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Text ("Round: \(round == 6 ? 5 : round)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                VStack(spacing: 15) {
                    if round == 6 {
                        Text("Game Over")
                            .font(.largeTitle.bold())
                            .foregroundColor(.red)
                            
                    } else {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        if number == correctAnswer {
                            Button {
                                self.animationAmount = 0
                                withAnimation {
                                    flagTapped(number: number)
                                    self.animationAmount += 360
                                }
                            } label: {
                                CapsuleFlag(image: countries[number])
                            }
                            .rotation3DEffect(.degrees(self.animationAmount), axis: (x: 0, y: 1, z: 0))
                        } else {
                            Button {
                                self.animationAmount = 0
                                withAnimation {
                                    flagTapped(number: number)
                                }
                            } label: {
                                CapsuleFlag(image: countries[number])
                            }
                            .opacity(showingScore ? 0.4 : 1)
                        }
                    }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            .alert("Game Over", isPresented: $gameOver) {
                Button("Play Again", action: reset)
            } message: {
                Text("Great job, your score was \(score)/5")
            }
        }
    }
    
    func flagTapped(number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
        } else {
            scoreTitle = "Sorry, that is incorrect!\nThe flag you chose was \(countries[number])"
        }
        round += 1
        showingScore = true
        gameOver = endOfGame()
    }
    
    func askQuestion() {
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func endOfGame() -> Bool {
        return round > 5
    }
    
    func reset() {
        score = 0
        round = 1
        countries = ["Estonia", "France", "Germany",
                    "Ireland", "Italy", "Nigeria",
                    "Poland", "Russia", "Spain",
                    "UK", "US"].shuffled()
        showingScore = false
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
