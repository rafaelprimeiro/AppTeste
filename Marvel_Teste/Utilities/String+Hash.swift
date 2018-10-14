//
//  String+Hash.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 13/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    func digest() -> String {
        let str = self.cString(using: .utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        
        return String(format: hash as String)

    }
}
