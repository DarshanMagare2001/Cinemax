//
//  SearchVC.swift
//  Cinemax
//
//  Created by IPS-161 on 01/02/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchVCProtocol: AnyObject {
    func updateUI()
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBarOutlet: UITextField!
    @IBOutlet weak var searchResultTblOutlet: UITableView!
    @IBOutlet weak var searchMessageView: UIView!
    
    var presenter: SearchVCPresenterProtocol?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        bindSearchBar()
        presenter?.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    @IBAction func clearSearchbtnPressed(_ sender: UIButton) {
        searchBarOutlet.text = nil
        UIView.transition(with: searchMessageView,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            self.searchMessageView.isHidden = false
        },completion: nil)
    }
    
}

extension SearchVC: SearchVCProtocol {
    
    func bindSearchBar(){
        searchBarOutlet.rx.text.orEmpty
            .debounce(.microseconds(600), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .bind(to: presenter!.searchQuery)
            .disposed(by: disposeBag)
    }
    
    func registerXib(){
        let nib = UINib(nibName: "MoviesCell", bundle: nil)
        searchResultTblOutlet.register(nib, forCellReuseIdentifier: "MoviesCell")
    }
    
    func updateUI(){
        UIView.transition(with: searchResultTblOutlet,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            self.searchResultTblOutlet.reloadData()
            self.searchMessageView.isHidden = true
        },completion: nil)
    }
    
}

extension SearchVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        if indexPath.section == 0{
            guard let cellData = presenter?.moviesDatasource else {
                return UITableViewCell()
            }
            cell.dataSource = cellData
            cell.cellTitleData = "Movies"
            cell.cellTappedClosure = { [weak self] data in
                self?.presenter?.gotoDetailVC(movieData: data)
            }
            cell.seeAllBtnPressedClosure = { [weak self] in
                self?.presenter?.gotoSeeAllVC(page: 1, searchText: self?.searchBarOutlet.text , movieId: 0, seeAllVCInputs: SeeAllVCInputs.fetchMovieSearch)
            }
            return cell
        }else if indexPath.section == 1{
            guard let cellData = presenter?.tvShowsDatasource else {
                return UITableViewCell()
            }
            cell.dataSource = cellData
            cell.cellTitleData = "TV Shows"
            return cell
        }
        return UITableViewCell()
    }
    
}
