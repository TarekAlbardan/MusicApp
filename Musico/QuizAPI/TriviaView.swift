//
//  TriviaView.swift
//  Musico
//
//  Created by MacBook on 2025-02-20.
//

import SwiftUI

struct TriviaView: View {
    @State private var questions: [TriviaQuestion] = []
    @State private var currentQuestionIndex = 0
    @State private var shuffledAnswers: [String] = []
    @State private var selectedAnswer: String? = nil
    @State private var showNextQuestion = false
    @State private var score = 0
    @State private var isQuizFinished = false

    var body: some View {
        ZStack {
                   // Background Color
                   Color(hex: "#1C2818")
                       .ignoresSafeArea()

                   VStack {
                       if isQuizFinished {
                           // 🎉 Final Score Screen
                           VStack(spacing: 20) {
                               Text("Quiz Completed! 🎉")
                                   .font(.largeTitle)
                                   .foregroundColor(.yellow)
                                   .bold()

                               Text("Final Score: \(score) / \(questions.count)")
                                   .font(.title)
                                   .bold()
                                   .foregroundColor(.white)

                               Text(getScoreMessage()) // 🏆 Show final message
                                   .font(.title2)
                                   .bold()
                                   .foregroundColor(.green)

                               Button(action: restartQuiz) {
                                   Text("Play Again")
                                       .font(.title2)
                                       .foregroundColor(.white)
                                       .padding()
                                       .frame(maxWidth: .infinity)
                                       .background(Color.blue)
                                       .cornerRadius(10)
                                       .shadow(radius: 5)
                               }
                               .padding(.horizontal, 40)
                           }
                           .padding()
                       } else {
                           // 🎤 Normal Quiz UI
                           HStack {
                               Button(action: previousQuestion) {
                                   Image(systemName: "chevron.left")
                                       .foregroundColor(.white)
                                       .padding()
                               }
                               Spacer()
                               Text("\(currentQuestionIndex + 1) - \(questions.count)")
                                   .foregroundColor(.white)
                                   .font(.headline)
                               Spacer()
                               Button(action: nextQuestion) {
                                   Image(systemName: "chevron.right")
                                       .foregroundColor(.white)
                                       .padding()
                               }
                           }

                           // Score Display
                           HStack {
                               Spacer()
                               Text("Score \(score)")
                                   .foregroundColor(.white)
                                   .font(.headline)
                                   .padding(.trailing, 20)
                           }

                           // Question Box
                           if questions.isEmpty {
                               ProgressView("Loading...")
                                   .foregroundColor(.white)
                           } else {
                               let question = questions[currentQuestionIndex]
                               
                               Text(question.question)
                                   .foregroundColor(.white)
                                   .font(.title2)
                                   .multilineTextAlignment(.center)
                                   .padding()
                                   .frame(minWidth: 300, maxWidth: 350, minHeight: 100, maxHeight: 200)
                                   .background(RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.5)))
                                   .padding()
                           }

                           // Answer Buttons
                           Text("Answer Correctly To Highlight Your Score")
                               .foregroundColor(.white)
                               .font(.subheadline)
                               .padding(.top, 10)

                           LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                               ForEach(shuffledAnswers, id: \.self) { answer in
                                   Button(action: {
                                       handleAnswerSelection(answer)
                                   }) {
                                       Text(answer)
                                           .padding()
                                           .frame(width: 160, height: 50)
                                           .background(buttonColor(for: answer))
                                           .foregroundColor(.white)
                                           .cornerRadius(25)
                                   }
                                   .disabled(selectedAnswer != nil)
                               }
                           }
                           .padding(.top, 10)
                       }
                   }
                   .padding()
               }
               .onAppear {
                   TriviaAPI.shared.fetchQuestions { fetchedQuestions in
                       if let fetchedQuestions = fetchedQuestions {
                           self.questions = fetchedQuestions
                           shuffleAnswers()
                       }
                   }
               }
           }

           func shuffleAnswers() {
               if !questions.isEmpty {
                   let question = questions[currentQuestionIndex]
                   shuffledAnswers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
               }
           }

           func handleAnswerSelection(_ answer: String) {
               selectedAnswer = answer
               if answer == questions[currentQuestionIndex].correctAnswer {
                   score += 1
               }
               showNextQuestion = true
           }

           func buttonColor(for answer: String) -> Color {
               if selectedAnswer == nil {
                   return Color.gray.opacity(0.8)
               } else if answer == questions[currentQuestionIndex].correctAnswer {
                   return Color.green
               } else if answer == selectedAnswer {
                   return Color.red
               }
               return Color.gray
           }

           func nextQuestion() {
               if currentQuestionIndex < questions.count - 1 {
                   currentQuestionIndex += 1
                   selectedAnswer = nil
                   showNextQuestion = false
                   shuffleAnswers()
               } else {
                   isQuizFinished = true
               }
           }

           func previousQuestion() {
               if currentQuestionIndex > 0 {
                   currentQuestionIndex -= 1
                   selectedAnswer = nil
                   showNextQuestion = false
                   shuffleAnswers()
               }
           }

           func getScoreMessage() -> String {
               switch score {
               case 0...5:
                   return "Try harder! 🎸"
               case 6...7:
                   return "Good! 🎵"
               case 8...9:
                   return "Perfect! 🌟"
               case 10:
                   return "Master of Music! 👑🎶"
               default:
                   return ""
               }
           }

           func restartQuiz() {
               score = 0
               currentQuestionIndex = 0
               isQuizFinished = false
               shuffleAnswers()
           }
       }
