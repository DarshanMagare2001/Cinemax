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
    
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var searchResultTblOutlet: UITableView!
    var presenter: SearchVCPresenterProtocol?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSearchBar()
        presenter?.viewDidload()
    }
    
    
}

extension SearchVC: SearchVCProtocol {
    func bindSearchBar(){
        searchBarOutlet.rx.text.orEmpty
            .debounce(.microseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .skip(1)
            .bind(to: presenter!.searchQuery)
            .disposed(by: disposeBag)
    }
}
