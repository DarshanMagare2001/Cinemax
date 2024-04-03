//
//  GenresVC.swift
//  Cinemax
//
//  Created by IPS-161 on 03/04/24.
//

import UIKit

protocol GenresVCProtocol: AnyObject {
    
}

class GenresVC: UIViewController {
    
    @IBOutlet weak var moviesBtn: RoundedButton!
    @IBOutlet weak var tvShowsBtn: RoundedButton!
    
    var presenter: GenresVCPresenterProtocol?
    
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
    
    
    @IBAction func contentToggleBtn(_ sender: UIButton) {
        toggleContent(tag: sender.tag)
    }
    
}

extension GenresVC: GenresVCProtocol {
    
    private func toggleContent(tag:Int){
        if tag == 0 {
            UIView.transition(with: self.moviesBtn,
                              duration: 0.3,
                              options: .transitionFlipFromRight,
                              animations: {
                self.moviesBtn.backgroundColor = .appBlue
                self.moviesBtn.isUserInteractionEnabled = false
                self.tvShowsBtn.isUserInteractionEnabled = true
                self.tvShowsBtn.backgroundColor = .clear
            },completion: nil)
        }else{
            UIView.transition(with: self.tvShowsBtn,
                              duration: 0.3,
                              options: .transitionFlipFromLeft,
                              animations: {
                self.tvShowsBtn.backgroundColor = .appBlue
                self.moviesBtn.isUserInteractionEnabled = true
                self.tvShowsBtn.isUserInteractionEnabled = false
                self.moviesBtn.backgroundColor = .clear
            },completion: nil)
        }
    }
    
}
