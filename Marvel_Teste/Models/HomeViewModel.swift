//
//  HomeViewModel.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 14/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: NSObject {
    let characters = BehaviorRelay<[Character]>(value: [Character]())
}
