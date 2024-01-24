//
//  OnboardingVCPresenter.swift
//  Cinemax
//
//  Created by IPS-161 on 24/01/24.
//

import Foundation

protocol OnboardingVCPresenterProtocol {
   func viewDidload()
}

class OnboardingVCPresenter {
    weak var view: OnboardingVCProtocol?
    var interactor: OnboardingVCInteractorProtocol
    var router: OnboardingVCRouterProtocol
    init(view: OnboardingVCProtocol,interactor: OnboardingVCInteractorProtocol,router: OnboardingVCRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension OnboardingVCPresenter: OnboardingVCPresenterProtocol {
    func viewDidload() {
        print("viewDidload")
    }
}
