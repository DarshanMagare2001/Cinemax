//
//  SearchVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 01/04/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchVCPresenterProtocol {
    func viewDidload()
    var searchQuery: BehaviorRelay<String> { get set }
}

class SearchVCPresenter {
    weak var view: SearchVCProtocol?
    var interactor: SearchVCInteractorProtocol
    var router: SearchVCRouterProtocol
    var searchQuery = BehaviorRelay<String>(value: "")
    let disposeBag = DisposeBag()
    init(view: SearchVCProtocol,interactor: SearchVCInteractorProtocol,router: SearchVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchVCPresenter: SearchVCPresenterProtocol {
    
    func viewDidload(){
        loadDatasource()
    }
    
    func loadDatasource(){
     
    }
    
}
