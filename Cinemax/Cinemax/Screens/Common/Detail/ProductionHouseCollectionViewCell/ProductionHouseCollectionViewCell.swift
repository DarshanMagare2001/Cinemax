//
//  ProductionHouseCollectionViewCell.swift
//  Cinemax
//
//  Created by IPS-161 on 18/03/24.
//

import UIKit

class ProductionHouseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellLbl: UILabel!
    func configure(productionCompany:ProductionCompany){
        let imgUrl = "https://image.tmdb.org/t/p/w500\(productionCompany.logoPath ?? "")"
        let name = productionCompany.name
        cellImg.loadImage(urlString: imgUrl, placeholder: "frame.fill")
        cellLbl.text = name
    }
}
