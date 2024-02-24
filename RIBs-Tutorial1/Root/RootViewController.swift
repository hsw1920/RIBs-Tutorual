////
////  RootViewController.swift
////  RIBs-Tutorial1
////
////  Created by 홍승완 on 2024/02/23.
////
//
//import RIBs
//import RxSwift
//import UIKit
//
//
//protocol RootPresentableListener: AnyObject {
//}
//
//final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
//    func present(viewController: ViewControllable) {
//        viewController.uiviewController.modalPresentationStyle = .fullScreen
//        self.present(viewController.uiviewController, animated: false)
//    }
//
//    weak var listener: RootPresentableListener?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .red
//    }
//   
//}
