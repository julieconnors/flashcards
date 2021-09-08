//
//  CardCell.swift
//  Flashcards
//
//  Created by Julie Connors on 9/8/21.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    static let identifier = String(describing: CardCell.self)

    @IBOutlet weak var headline: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        headline.text = "headline"
    }
}
