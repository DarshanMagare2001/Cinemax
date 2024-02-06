//
//  UpcomingMoviesCell.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import UIKit
import FSPagerView
import Kingfisher

class UpcomingMoviesCell: UITableViewCell  {
    
    
    @IBOutlet weak var pagerViewOutlet: FSPagerView! {
        didSet{
            self.pagerViewOutlet.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerViewOutlet.transformer = FSPagerViewTransformer(type: .overlap)
        }
    }
    
    var cellData = [MasterMoviesModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pagerViewOutlet.dataSource = self
        pagerViewOutlet.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(dataSource:[MasterMoviesModel]){
        cellData = dataSource
        pagerViewOutlet.reloadData()
    }
    
}

extension UpcomingMoviesCell: FSPagerViewDataSource , FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return cellData.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let imageUrl = cellData[index].moviesPosterModel.poster
        if var urlComponents = URLComponents(string: imageUrl) {
            urlComponents.scheme = "https"
            if let httpsUrl = urlComponents.url {
                ImageLoader.loadImage(imageView: cell.imageView!, imageUrl: httpsUrl.absoluteString, placeHolderType: .systemName, placeHolderImage: "person.fill")
            }
        }
        cell.textLabel?.text = cellData[index].movieModel.title
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    
}
