//
//  AccountViewController.swift
//  TVToday
//
//  Created by Jeans Ruiz on 6/19/20.
//  Copyright © 2020 Jeans. All rights reserved.
//

import UIKit
import RxSwift

class AccountViewController: UIViewController, StoryboardInstantiable {
  
  private var viewModel: AccountViewModel!
  
  private var signInViewController: SignInViewController!
  
  private var profileViewController: ProfileViewController!
  
  static func create(with viewModel: AccountViewModel,
                     signInViewController: SignInViewController,
                     profileViewController: ProfileViewController) -> AccountViewController {
    let controller = AccountViewController.instantiateViewController()
    controller.viewModel = viewModel
    controller.signInViewController = signInViewController
    controller.profileViewController = profileViewController
    return controller
  }
  
  private let disposeBag = DisposeBag()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cyan
    
    subscribe()
  }
  
  // MARK: - Setup UI
  
  fileprivate func subscribe() {
    viewModel.output.viewState
      .debug()
      .subscribe(onNext: { [weak self] viewState in
        self?.setupUI(with: viewState)
      })
      .disposed(by: disposeBag)
  }
  
  fileprivate func setupUI(with state: AccountViewModel.ViewState) {
    switch state {
    case .login:
      remove(asChildViewController: profileViewController)
      add(asChildViewController: signInViewController)
      
    case .profile:
      remove(asChildViewController: signInViewController)
      add(asChildViewController: profileViewController)
    }
  }
}
