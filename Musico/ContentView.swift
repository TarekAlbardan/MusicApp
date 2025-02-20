//
//  ContentView.swift
//  Musico
//
//  Created by MacBook on 2025-02-18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("🎵 Music Trivia 🎵")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                NavigationLink(destination: TriviaView()) {
                    Text("Start Quiz")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
