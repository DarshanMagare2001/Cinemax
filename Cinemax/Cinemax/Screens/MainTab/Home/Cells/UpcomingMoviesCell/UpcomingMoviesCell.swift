//
//  UpcomingMoviesCell.swift
//  Cinemax
//
//  Created by IPS-161 on 06/02/24.
//

import UIKit
import FSPagerView
import Kingfisher
import JXPageControl

class UpcomingMoviesCell: UITableViewCell  {
    
    
    @IBOutlet weak var pagerViewOutlet: FSPagerView! {
        didSet{
            self.pagerViewOutlet.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerViewOutlet.transformer = FSPagerViewTransformer(type: .overlap)
        }
    }
    @IBOutlet weak var pageControl: JXPageControlEllipse!
    
    var indexpath = 0 {
        didSet{
            let progress = CGFloat(indexpath) / CGFloat(cellData.count)
            pageControl.progress = progress
            pageControl.currentPage = indexpath
        }
    }
    
    var cellData = [MasterMoviesModel]() {
        didSet{
            pageControl.numberOfPages = cellData.count
            let progress = CGFloat(indexpath) / CGFloat(cellData.count)
            pageControl.progress = progress
            pageControl.currentPage = indexpath
        }
    }
    
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
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int){
        indexpath = targetIndex
    }
   
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let imageUrl = cellData[index].moviesPosterModel.poster
        
        // Set corner radius for imageView
        cell.imageView?.layer.cornerRadius = 20
        cell.imageView?.layer.masksToBounds = true
        
        // Remove existing labels
        cell.imageView?.subviews.forEach { $0.removeFromSuperview() }
        
        // Create UILabels
        let cellMovieTitleLbl = UILabel()
        let cellMovieReleaseDateLbl = UILabel()
        
        // Customize UILabels (set text, font, color, etc.)
        cellMovieTitleLbl.text = cellData[index].movieModel.title
        cellMovieReleaseDateLbl.text = cellData[index].movieModel.releaseDate
        cellMovieTitleLbl.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        cellMovieTitleLbl.textColor = UIColor.appBlue
        cellMovieReleaseDateLbl.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        cellMovieReleaseDateLbl.textColor = UIColor.appBlue
        
        // Similarly, customize cellMovieReleaseDateLbl
        
        // Create a vertical stack view to hold the UILabels
        let stackView = UIStackView(arrangedSubviews: [cellMovieTitleLbl, cellMovieReleaseDateLbl])
        stackView.axis = .vertical
        stackView.spacing = 5 // Adjust spacing as needed
        
        // Add the stack view as a subview to cell.imageView
        cell.imageView?.addSubview(stackView)
        
        // Set constraints for the stack view to position it within the imageView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: cell.imageView!.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: cell.imageView!.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: cell.imageView!.bottomAnchor, constant: -30)
        ])
        
        // Load image using ImageLoader (adjust placeholder as needed)
        if var urlComponents = URLComponents(string: imageUrl) {
            urlComponents.scheme = "https"
            if let httpsUrl = urlComponents.url {
                ImageLoader.loadImage(imageView: cell.imageView!, imageUrl: httpsUrl.absoluteString, placeHolderType: .systemName, placeHolderImage: "person.fill")
            }
        }
        
        return cell
    }
    
}

