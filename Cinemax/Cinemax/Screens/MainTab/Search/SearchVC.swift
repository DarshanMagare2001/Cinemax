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
    }
    
}

extension SearchVC: SearchVCProtocol {
    
    func bindSearchBar(){
        searchBarOutlet.rx.text.orEmpty
            .debounce(.microseconds(600), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .skip(1)
            .filter { !$0.isEmpty }
            .bind(to: presenter!.searchQuery)
            .disposed(by: disposeBag)
    }
    
    func registerXib(){
        let nib = UINib(nibName: "MoviesCell", bundle: nil)
        searchResultTblOutlet.register(nib, forCellReuseIdentifier: "MoviesCell")
    }
    
    func updateUI(){
        searchResultTblOutlet.reloadData()
    }
    
}

extension SearchVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        guard let cellData = presenter?.datasource else {
            return UITableViewCell()
        }
        cell.dataSource = cellData
        cell.cellTitleData = "Movies"
        return cell
    }
    
}
