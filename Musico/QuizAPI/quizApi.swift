//
//  quizApi.swift
//  Musico
//
//  Created by MacBook on 2025-02-20.
//
import Foundation

@Observable
class TriviaAPI {
    static let shared = TriviaAPI()
    
    func fetchQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
        guard let url = URL(string: "https://the-trivia-api.com/api/questions?categories=music&limit=10") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching questions: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ No data received")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // ✅ Auto-fix JSON keys
                let questions = try decoder.decode([TriviaQuestion].self, from: data)
                DispatchQueue.main.async {
                    completion(questions)
                }
            } catch {
                print("❌ Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
