//
//  ApiModel.swift
//  QiitaAPI
//
//  Created by Haruko Okada on 2/15/21.
//

import Foundation

protocol QiitaApiMethods {
    func getQiitaApi(completion: @escaping ([Qiita]) -> ()) 
}

struct Qiita: Codable {
    var title: String
    var url: String
    var createdAt: String
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case url = "url"
        case createdAt = "created_at"
        case user = "user"
    }
}

struct User: Codable {
    var name: String
    var profileImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case profileImageUrl = "profile_image_url"
    }
    
}


class ApiModel {
    
    func getQiitaApi(completion: @escaping ([Qiita]) -> ()) {

        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20") else { return }

//        guard var urlComponents = URLComponents(string: url) else { return }

//            urlComponents.queryItems = [
//                URLQueryItem(name: "per_page", value: "50"),
//            ]

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print("can't retreive data", err)
                return
            }

            if let data = data {

                do {
                    let qiitaArticle = try JSONDecoder().decode([Qiita].self, from: data)
                    print("success")
                    completion(qiitaArticle)
                    print("json:", qiitaArticle)
                } catch {
                    print("can't retreive data", error)
                }
            }
        }
            task.resume()
    }


}
