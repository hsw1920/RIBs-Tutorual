//
//  LoggedInInteractor.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/23.
//

import RIBs
import RxSwift

protocol LoggedInRouting: ViewableRouting {
    
}

protocol LoggedInPresentable: Presentable {
    var listener: LoggedInPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedInListener: AnyObject {
    func logoutButtonDidTap()
}

final class LoggedInInteractor: PresentableInteractor<LoggedInPresentable>, LoggedInInteractable, LoggedInPresentableListener {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedInPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func logout() {
        listener?.logoutButtonDidTap()
    }
}
