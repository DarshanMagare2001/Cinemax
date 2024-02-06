//
//  HomeVC.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import UIKit

protocol HomeVCProtocol: class {
    func updateUI()
}

class HomeVC: UIViewController {
    
    var presenter: HomeVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
}

extension HomeVC: HomeVCProtocol {
    
    func updateUI(){
        print(presenter?.upcomingMovies)
        print(presenter?.nowplayingMovies)
        print(presenter?.trendingMovies)
        print(presenter?.boxofficeMovies)
    }
    
}
