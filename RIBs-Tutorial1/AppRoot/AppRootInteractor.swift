//
//  AppRootInteractor.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/24.
//

import RIBs
import RxSwift
import RxCocoa

protocol AppRootRouting: ViewableRouting {
    func attachLoggedIn()
    func attachLoggedOut()
    
    func detachLoggedIn()
    func detachLoggedOut()
}

protocol AppRootPresentable: Presentable {
    var listener: AppRootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AppRootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>, AppRootInteractable, AppRootPresentableListener {

    weak var router: AppRootRouting?
    weak var listener: AppRootListener?

    private let loginRepository: LoginRepository
    private let loginState: PublishSubject<LoginState> = PublishSubject<LoginState>()
    
    private var disposeBag = DisposeBag()
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    
    init(
        presenter: AppRootPresentable,
        loginRepository: LoginRepository
    ) {
        self.loginRepository = loginRepository
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        loginState
            .withUnretained(self)
            .subscribe(onNext: { owner, state in
                switch state {
                case .loggedIn:
                    owner.router?.attachLoggedIn()
                case .loggedOut:
                    owner.router?.attachLoggedOut()
                }
            })
            .disposed(by: disposeBag)
        
        loginRepository.isLoggedIn
            .map { LoginState(rawValue: $0) }
            .bind(to: loginState)
            .disposed(by: disposeBag)

    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    fileprivate enum LoginState: RawRepresentable {
        typealias RawValue = Bool
        
        case loggedIn
        case loggedOut
        
        init(rawValue: RawValue) {
            switch rawValue {
            case true:
                self = .loggedIn
            case false:
                self = .loggedOut
            }
        }
        
        var rawValue: Bool {
            switch self {
            case.loggedIn:
                return true
            case .loggedOut:
                return false
            }
        }
    }
    
}

extension AppRootInteractor {
    // MARK: LoggedIn, LoggedOut과 커뮤니케이션
    
    func logoutButtonDidTap() {
        router?.detachLoggedIn()
        router?.attachLoggedOut()
    }
    
    func loginButtonDidTap() {
        router?.detachLoggedOut()
        router?.attachLoggedIn()
    }
}
