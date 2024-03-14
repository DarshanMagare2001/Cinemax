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
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDateLbl: UILabel!
    
    @IBOutlet weak var pagerViewOutlet: FSPagerView! {
        didSet{
            self.pagerViewOutlet.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerViewOutlet.transformer = FSPagerViewTransformer(type: .overlap)
        }
    }
    
    var indexpath = 0 {
        didSet{
            DispatchQueue.main.async { [weak self] in
                if let data = self?.cellData?.results[self?.indexpath ?? 0] {
                    self?.movieTitle.text = data.originalTitle
                    self?.movieReleaseDateLbl.text = data.releaseDate
                }
            }
        }
    }
    
    var cellData : MasterMovieModel? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                if let data = self?.cellData?.results[0] {
                    self?.movieTitle.text = data.originalTitle
                    self?.movieReleaseDateLbl.text = data.releaseDate
                }
            }
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
    
    func configureCell(dataSource: MasterMovieModel?){
        cellData = dataSource
        pagerViewOutlet.reloadData()
    }
    
}

extension UpcomingMoviesCell: FSPagerViewDataSource , FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return cellData?.results.count ?? 0
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int){
        indexpath = targetIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let imageUrl = "https://image.tmdb.org/t/p/w500\(cellData?.results[index].posterPath ?? "")"
        // Set corner radius for imageView
        cell.imageView?.layer.cornerRadius = 20
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.white.cgColor  // Set borderColor to UIColor.white.cgColor
        
        DispatchQueue.main.async { [weak self] in
            cell.imageView?.loadImage(urlString: imageUrl, placeholder: "frame.fill")
        }
        
        return cell
    }
    
    
}

