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
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color(UIColor.darkGray)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    // Title
                    Text("🎵 Musico 🎵")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    // "Start Quiz" Button
                    NavigationLink(destination: TriviaView()) {
                        Text("Start Quiz")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 30)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
