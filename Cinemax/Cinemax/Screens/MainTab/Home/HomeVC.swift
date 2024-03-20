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
    func registerXib()
    func addRefreshcontroToTableview()
}

class HomeVC: UIViewController {
    
    @IBOutlet weak var userImg: CircleImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var moviesTableViewOutlet: UITableView!
    
    var presenter: HomeVCPresenterProtocol?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 1, y: 1)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        presenter?.loadDataSource()
    }
    
}

extension HomeVC: HomeVCProtocol {
    
    func setupUI(name:String,profileImgUrl:String){
        userNameLbl.text = name
        userImg.loadImage(urlString: profileImgUrl, placeholder: "person.fill")
    }
    
    func updateUI(){
        self.refreshControl.perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: 0)
        moviesTableViewOutlet.reloadData()
    }
    
    func registerXib(){
        let nib = UINib(nibName: "MoviesCell", bundle: nil)
        moviesTableViewOutlet.register(nib, forCellReuseIdentifier: "MoviesCell")
    }
    
    func addRefreshcontroToTableview(){
        moviesTableViewOutlet.addSubview(refreshControl)
    }
    
}

extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingMoviesCell", for: indexPath) as! UpcomingMoviesCell
            DispatchQueue.main.async { [weak self] in
                if let upcomingMovies = self?.presenter?.movieUpcomingDatasource {
                    cell.configureCell(dataSource: upcomingMovies)
                }
            }
            
            cell.cellTappedClosure = { [weak self] data in
                self?.presenter?.gotoDetailVC(movieData:data)
            }
            
            cell.seeAllBtnpressedClosure = { [weak self] in
                self?.presenter?.gotoSeeAllVC(page: 1, searchText: "", movieId: 0, seeAllVCInputs: SeeAllVCInputs.fetchMovieUpcoming)
            }
            
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
            DispatchQueue.main.async { [weak self] in
                if let movieTopRated = self?.presenter?.movieTopRatedDatasource {
                    cell.dataSource = movieTopRated
                    cell.cellTitleData = "TOPRATED"
                }
            }
            
            cell.seeAllBtnPressedClosure = { [weak self] in
                self?.presenter?.gotoSeeAllVC(page: 1, searchText: "", movieId: 0, seeAllVCInputs: SeeAllVCInputs.fetchMovieTopRated)
            }
            
            cell.cellTappedClosure = { [weak self] data in
                self?.presenter?.gotoDetailVC(movieData:data)
            }
            
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
            DispatchQueue.main.async { [weak self] in
                if let movieNowPlaying = self?.presenter?.movieNowPlayingDatasource {
                    cell.dataSource = movieNowPlaying
                    cell.cellTitleData = "NOWPLAYING"
                }
            }
            
            cell.seeAllBtnPressedClosure = { [weak self] in
                self?.presenter?.gotoSeeAllVC(page: 1, searchText: "", movieId: 0, seeAllVCInputs: SeeAllVCInputs.fetchMovieNowPlaying)
            }
            
            cell.cellTappedClosure = { [weak self] data in
                self?.presenter?.gotoDetailVC(movieData:data)
            }
            
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
            DispatchQueue.main.async { [weak self] in
                if let moviePopular = self?.presenter?.moviePopularDatasource {
                    cell.dataSource = moviePopular
                    cell.cellTitleData = "POPULAR"
                }
            }
            
            cell.seeAllBtnPressedClosure = { [weak self] in
                self?.presenter?.gotoSeeAllVC(page: 1, searchText: "", movieId: 0, seeAllVCInputs: SeeAllVCInputs.fetchMoviePopular)
            }
            
            cell.cellTappedClosure = { [weak self] data in
                self?.presenter?.gotoDetailVC(movieData:data)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}
