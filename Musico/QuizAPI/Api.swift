//
//  Api.swift
//  Musico
//
//  Created by MacBook on 2025-02-18.
//

import Foundation

struct TriviaQuestion: Identifiable, Decodable {
    let id: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let difficulty: String
}

