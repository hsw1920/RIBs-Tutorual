//
//  AppRootInteractor.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/24.
//

import RIBs
import RxSwift
import RxCocoa

protocol AppRootRouting: Routing {
    func setupLoggedIn()
    func setupLoggedOut()
    func attachLoggedIn()
    func attachLoggedOut()
    func detachLoggedIn()
    func detachLoggedOut()
}

protocol AppRootListener: AnyObject {
    
}

final class AppRootInteractor: Interactor, AppRootInteractable {
    
    weak var router: AppRootRouting?
    weak var listener: AppRootListener?

    private let loginRepository: LoginRepository

    private var disposeBag = DisposeBag()
    init
    (
        loginRepository: LoginRepository
    ) {
        self.loginRepository = loginRepository
        
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        loginRepository.isLoggedIn
            .subscribe(onNext: { [weak self] isLoggedIn in
                if isLoggedIn {
                    self?.router?.setupLoggedIn()
                } else {
                    self?.router?.setupLoggedOut()
                }
            })
            .disposed(by: disposeBag)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func attachLoggedIn() {
        router?.attachLoggedIn()
    }
    
    func detachLoggedIn() {
        router?.detachLoggedIn()
    }
    
    func attachLoggedOut() {
        router?.attachLoggedOut()
    }
    
    func detachLoggedOut() {
        router?.detachLoggedOut()
    }
}
