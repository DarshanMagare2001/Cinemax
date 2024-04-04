//
//  WishListVC.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import UIKit

protocol WishListVCProtocol: AnyObject {
    
}

class WishListVC: UIViewController {
    
    var presenter: WishListVCPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

extension WishListVC: WishListVCProtocol {
    
}
