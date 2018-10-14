//
//  AppConfig.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 13/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import UIKit

struct ServiceConfig: Codable {
    
    let privateKey:String
    let publicKey:String
    
    enum CodingKeys: String, CodingKey {
        case privateKey
        case publicKey
    }
}
