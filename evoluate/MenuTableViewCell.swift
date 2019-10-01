//
//  MenuTableViewCell.swift
//  LNSideMenu
//
//  Created by Aakarsh

//

import UIKit

class MenuTableViewCell: UITableViewCell {
  
  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
}
