//
//  AppRootViewController.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/24.
//

import RIBs
import RxSwift
import UIKit

protocol AppRootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AppRootViewController: UIViewController, AppRootPresentable, AppRootViewControllable {
    
    weak var listener: AppRootPresentableListener?
    
}
