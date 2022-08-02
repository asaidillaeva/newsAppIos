//
//  NetworkService.swift
//  ArticlesApp
//
//  Created by Aliia Saidillaeva  on 20/7/22.
//

import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func sendRequest<SuccessModel: Decodable>(
        router: BaseRouter,
        successModel: SuccessModel.Type,
        completion: @escaping (Result<SuccessModel, Error>) -> ()
    ) { 
        urlSession.dataTask(with: router.getURLRequest()) { data, response, error in
            if let error = error {
                print("Error message is: " + error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response status code is: " + response.statusCode.description)
                print(response.url!)
            }
           
            guard let data = data else { return }
            guard
                let object = try? JSONSerialization.jsonObject(with: data, options: []),
                let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            else { return }
            print(#function, prettyPrintedString)
            if let parsedModel = self.transform(data: data, model: successModel) {
                DispatchQueue.main.async {
                    completion(.success(parsedModel))
                }
            } else {
                print("invalidModel")
            }
            
        }.resume()
    }
    
    func getImage(imageUrl: String,
                  completion: @escaping (Result<UIImage, Error>) -> ()
    ) -> () {
        guard let url = URL(string: imageUrl) else {
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                completion(.failure(error!))
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(image))
            }
        }
    }
    
    private func transform<SuccessModel: Decodable>(data: Data, model: SuccessModel.Type) -> SuccessModel? {
        try? JSONDecoder().decode(model, from: data)
    }
}

