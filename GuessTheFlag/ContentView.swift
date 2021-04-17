//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dhananjay Magdum on 20/03/21.
//  Copyright © 2021 Atlas Copco. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var wrongAnswer = 0
    @State private var totalClicks = 0
    @State private var correctAnswers = 0
    @State private var arrayOfFlagsDisplayed = [String]()
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 10) {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("SCORE: \(correctAnswers) \\ \(totalClicks)")
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            let message  = scoreTitle == "Correct" ? "Your score is \(correctAnswers) \\ \(totalClicks)" : "That's the flag of \(countries[wrongAnswer])"
            return Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        totalClicks += 1
        if number==correctAnswer {
            scoreTitle = "Correct"
            correctAnswers += 1
        } else {
            scoreTitle = "Wrong"
            wrongAnswer = number
        }
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
