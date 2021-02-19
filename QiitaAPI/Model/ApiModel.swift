//
//  ApiModel.swift
//  QiitaAPI
//
//  Created by Haruko Okada on 2/15/21.
//

import Foundation

struct Dog: Codable {
    var name: String
    var image: Image
    var temperament: String? = "no recorded temperament"
}

struct Image: Codable {
    var url: String
}





class ApiModel {
    

    

}
