//
//  MakeCollectionViewCell.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import UIKit
import Kingfisher

class MakeTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func setData(make: RealmMake) {
        self.nameLabel.text = make.name
        loadImage(url: make.logoUri)
    }
    
    func loadImage(url: String) {
        guard let url = URL.init(string: url) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            self.imgView.image = image
        })
    }
}
