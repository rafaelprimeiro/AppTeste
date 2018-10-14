//
//  DetailViewController.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 14/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgCharacter:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDetail:UILabel!
    
    var character:Character! {
        didSet {
            updateValues()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateValues()
    }
    
    func updateValues() {
        imgCharacter?.loadImageWithUrl(string: "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)")
        lblTitle?.text = character.name
        lblDetail?.text = character.description
        lblDetail?.sizeToFit()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
