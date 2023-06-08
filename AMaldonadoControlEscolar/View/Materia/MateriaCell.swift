//
//  MateriaCell.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import UIKit
import SwipeCellKit

class MateriaCell: SwipeTableViewCell {
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblCosto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
