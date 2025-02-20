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
    @State private var score: Int = 0
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showNextQuestion = false
            shuffleAnswers()
        }
    }

    var body: some View {
        VStack {
            Text("Score: \(score) / \(questions.count)")
                           .font(.title2)
                           .bold()
                           .padding()
            if questions.isEmpty {
                ProgressView("Loading...")
            } else {
                let question = questions[currentQuestionIndex]
                
                Text(question.category)
                    .font(.headline)
                    .foregroundColor(.blue)

                Text(question.question) // ✅ Correctly display the question
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                ForEach(shuffledAnswers, id: \.self) { answer in
                    Button(action: {
                        selectedAnswer = answer
                        showNextQuestion = true
                    }) {
                        Text(answer)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(buttonColor(for: answer))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(selectedAnswer != nil)
                }
                
                if showNextQuestion {
                    Button("Next Question") {
                        nextQuestion()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
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
            if answer ==
questions[currentQuestionIndex].correctAnswer {
                score += 1
            }
            showNextQuestion = true
        }
    func buttonColor(for answer: String) -> Color {
        if selectedAnswer == nil {
            return Color.blue
        } else if answer == questions[currentQuestionIndex].correctAnswer {
            return Color.green
        } else if answer == selectedAnswer {
            return Color.red
        }
        return Color.gray
    }
    
}
