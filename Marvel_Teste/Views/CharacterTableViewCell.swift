//
//  CharacterTableViewCell.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 14/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var lblTitle:UILabel!
    @IBOutlet private weak var imgCharacter:UIImageView!
    
    var character:Character? = nil {
        didSet {
            guard let character = character else {
                lblTitle.text = ""
                imgCharacter.image = nil
                return
            }
            if (lblTitle == nil) { return }
            lblTitle.text = character.name
            imgCharacter.loadImageWithUrl(string: "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCharacter.layer.cornerRadius = 20
        imgCharacter.layer.masksToBounds = true
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
