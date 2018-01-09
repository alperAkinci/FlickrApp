//
//  FlickrAPI.swift
//  FlickrApp
//
//  Created by Alper Akinci on 02/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import Moya
import RxSwift

// ** MOYA Endpoint Implemantation **

enum Flickr {
    case photoList(searchQuery: String)
    case fetchImage(serverID: String, secret: String, imageID: String)
}

extension Flickr: TargetType {

    var base: String {
        switch self {
        case .fetchImage(_, _, _):
            return Config.FLICKRURL
        default:
            return Config.SERVER_URL
        }
    }

    var baseURL: URL {
        return URL(string: base)!
    }

    var path: String {
        switch self {
        case .photoList(_):
            return "/services/rest"

        case .fetchImage(let serverID, let secret, let imageID):
            return "/\(serverID)/\(imageID)_\(secret).jpg"  //https://farm5.static.flickr.com/4216/35030306426_82211e574e.jpg
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    // do not need to add the parameters using the parameters property of TargetType in Moya 9.0. Basically, parameters and task has been combined into a single property.
    // Check -> https://github.com/Moya/Moya/issues/1276
    var task: Task {
        switch self {
        case .photoList(let searchQuery):
            return .requestParameters(
            parameters: [
                    "method": "flickr.photos.search",
                    "api_key": Config.FLICKRAPIKEY,
                    "format": "json",
                    "nojsoncallback": 1,
                    "safe_search": 1,
                    "text": searchQuery,
                    "page": 1, // test
                    "per_page": 10], // test,
            encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }
    
    func url() -> URL {
        return self.baseURL.appendingPathComponent(self.path)
    }
}
