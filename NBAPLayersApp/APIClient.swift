//
//  APIClient.swift
//  NBAPLayersApp
//
//  Created by Александр Зубарев on 18.01.2021.
//

import Foundation

enum ApiError: Error {
    case noData
}

protocol ApiClient {
    func getPlayers(completion: @escaping (Result<[Player], Error>) -> Void)
}

class ApiClientImpl: ApiClient {
    func getPlayers(completion: @escaping (Result<[Player], Error>) -> Void) {
        let session = URLSession.shared
        
        let url = URL(string: "https://www.balldontlie.io/api/v1/players")
        let urlRequest = URLRequest(url: url!)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            //код для тестирования логики программы при ошибке соединения
//            sleep(5)
//            completion(.failure(ApiError.noData))
//            return
            //---------------------------------
            
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            //данные есть
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(PlayersResponse.self, from: data)
                completion(.success(response.data))
            } catch (let error) {
                print(error)
                completion(.failure(error))
            }
        })
        
        dataTask.resume()
    }
}
