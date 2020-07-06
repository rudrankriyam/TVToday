//
//  PopularsViewModel.swift
//  MyTvShows
//
//  Created by Jeans on 9/16/19.
//  Copyright © 2019 Jeans. All rights reserved.
//

import RxSwift
import RxFlow
import RxRelay
import Shared

final class PopularViewModel: ShowsViewModel {
  
  var steps = PublishRelay<Step>()
  
  var fetchTVShowsUseCase: FetchTVShowsUseCase
  
  var shows: [TVShow]
  
  var showsCells: [TVShowCellViewModel] = []
  
  var viewStateObservableSubject: BehaviorSubject<SimpleViewState<TVShowCellViewModel>> = .init(value: .loading)
  
  var  disposeBag = DisposeBag()
  
  var input: Input
  
  var output: Output
  
  // MARK: - Initializers
  
  init(fetchTVShowsUseCase: FetchTVShowsUseCase) {
    self.fetchTVShowsUseCase = fetchTVShowsUseCase
    shows = []
    
    self.input = Input()
    self.output = Output(viewState: viewStateObservableSubject.asObservable())
  }
  
  func mapToCell(entites: [TVShow]) -> [TVShowCellViewModel] {
    return entites.map { TVShowCellViewModel(show: $0) }
  }
}

// MARK: - BaseViewModel

extension PopularViewModel: BaseViewModel {
  
  public struct Input { }
  
  public struct Output {
    let viewState: Observable<SimpleViewState<TVShowCellViewModel>>
  }
}

// MARK: - Stepper

extension PopularViewModel {
  
  public func navigateTo(step: Step) {
    steps.accept(step)
  }
}