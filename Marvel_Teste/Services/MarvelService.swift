//
//  MarvelService.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 13/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import UIKit

class MarvelService {
    
    static let shared:MarvelService = try! MarvelService()
    var serviceConfig:ServiceConfig!
    
    let sessionConfig = URLSessionConfiguration.default
    
    init() throws {
        do {
            let url = Bundle.main.url(forResource: "Config", withExtension: "plist")
            let plist = try Data(contentsOf: url!)
            let pListDecoder = PropertyListDecoder()
            serviceConfig = try pListDecoder.decode(ServiceConfig.self, from: plist)
        } catch let error {
            assert(false, "Error on load config file.")
            throw error
        }
    }
    
    func hash(ts:UInt64) -> String {
        let hashFormatted = "\(ts)\(serviceConfig.privateKey)\(serviceConfig.publicKey)"
        return hashFormatted.digest()
    }
    
    func sendRequestCharacters(_ offset:Int, _ completeHandler: @escaping (MarvelResult?) -> Void) {
        print("offset: \(offset)")
        let ts = Date().timeIntervalSince1970.bitPattern
        
        guard var URL = URL(string: "https://gateway.marvel.com/v1/public/characters") else {return}
        let URLParams = [
            "ts": "\(ts)",
            "apikey": "\(serviceConfig.publicKey)",
            "hash": hash(ts: ts),
            "limit":"80",
            "offset":"\(offset)"
        ]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        // Headers
        request.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MarvelResult.self, from: data!)
//                    dump(result)
                    completeHandler(result)
                    return
                } catch let error {
                    print("Parse error \(error.localizedDescription)")
                }
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
            completeHandler(nil)
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}


