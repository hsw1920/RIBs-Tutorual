//
//  LoggedOutRouter.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/23.
//

import RIBs

protocol LoggedOutInteractable: Interactable {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    override init
    (
        interactor: LoggedOutInteractable,
        viewController: LoggedOutViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
