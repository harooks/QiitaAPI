//
//  ApiModel.swift
//  QiitaAPI
//
//  Created by Haruko Okada on 2/15/21.
//

import Foundation

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
    

    

}
