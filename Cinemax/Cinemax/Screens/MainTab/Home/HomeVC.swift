//
//  HomeVC.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import UIKit

protocol HomeVCProtocol: class {
    func setupUI(name:String,profileImgUrl:String)
    func updateUI()
}

class HomeVC: UIViewController {
    
    @IBOutlet weak var userImg: CircleImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var moviesTableViewOutlet: UITableView!
    
    var presenter: HomeVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

extension HomeVC: HomeVCProtocol {
    
    func setupUI(name:String,profileImgUrl:String){
        userNameLbl.text = name
        ImageLoader.loadImage(imageView: userImg, imageUrl: profileImgUrl, placeHolderType: .systemName, placeHolderImage: "person.fill")
    }
    
    func updateUI(){
        moviesTableViewOutlet.reloadData()
    }
    
}

extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingMoviesCell", for: indexPath) as! UpcomingMoviesCell
        DispatchQueue.main.async { [weak self] in
            if let upcomingMovies = self?.presenter?.upcomingMovies {
                cell.configureCell(dataSource: upcomingMovies)
            }
        }
        return cell
    }
    
}
