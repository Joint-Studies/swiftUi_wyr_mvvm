//
//  ContentView.swift
//  wyr_app
//
//  Created by Rodrigo Silva on 01/07/24.
//

import SwiftUI
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift

struct ContentView: View {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var questionViewModel = QuestionViewModel()

    var body: some View {
        let (part1, part2, part3) = splitStringByIsolatedWord(questionViewModel.question?.question ?? "", word: "or")

        ZStack {
                   VStack(spacing: 0) {
                       Color.red
                           .overlay(
                               Text(part1)
                                   .font(.title)
                                   .foregroundColor(.white)
                                   .padding(.horizontal, 20)
                           )
                           .frame(maxWidth: .infinity, maxHeight: .infinity)

                       Color.blue
                           .overlay(
                               Text(part3)
                                   .font(.title)
                                   .foregroundColor(.white)
                                   .padding(.horizontal, 20)
                           )
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                   }
                   .edgesIgnoringSafeArea(.all)

                   Circle()
                .fill(Color.black)
                       .frame(width: 100, height: 100)
                       .overlay(
                           Text(part2)
                               .font(.title)
                               .foregroundColor(.white)
                       )

                   VStack {
                       Spacer()
                       Button(action: {
                           questionViewModel.fetchQuestion()
                       }) {
                           Text("Next")
                               .font(.title)
                               .padding()
                               .background(Color.green)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
                       .padding(.bottom, 20)
                   }
               }
        .onAppear{
            questionViewModel.fetchQuestion()
        }
        
    }
    
    func splitStringByIsolatedWord(_ input: String, word: String) -> (String, String, String) {
        let pattern = "\\b" + NSRegularExpression.escapedPattern(for: word) + "\\b"
        if let range = input.range(of: pattern, options: .regularExpression) {
            let firstPart = String(input[input.startIndex..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
            let secondPart = word
            let thirdPart = String(input[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            return (firstPart, secondPart, thirdPart)
        } else {
            return("","","")
        }
    }
}

#Preview {
    ContentView()
}
