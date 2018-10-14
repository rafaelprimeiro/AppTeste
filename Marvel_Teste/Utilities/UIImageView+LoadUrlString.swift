//
//  UIImageView+LoadUrlString.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 14/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageWithUrl(string:String) {
        let url = URL(string: string)
        self.tag = Date().hashValue
        let tag = self.tag
        
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: string as AnyObject) as? UIImage {
            if (tag != self.tag) { return }
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if (error != nil) {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                let image = UIImage(data: data)
                imageCache.setObject(image!, forKey: string as AnyObject)
                if (tag != self.tag) { return }
                self.image = image!
            }
        }.resume()
    }
}
