//
//  TVShowListViewModel.swift
//  MyTvShows
//
//  Created by Jeans on 9/16/19.
//  Copyright © 2019 Jeans. All rights reserved.
//

import Foundation

final class TVShowListViewModel: ShowsViewModel{
    private let showsService = ApiClient<TVShowsProvider>()
    
    var shows: [TVShow]
    var models: [TVShowCellViewModel]
    
    var genreId: Int!
    
    //Bindable
    var viewState:Bindable<ViewState> = Bindable(.loading)
    
    init(genreId: Int) {
        self.genreId = genreId
        shows = []
        models = []
    }
    
    func getMoviesForGenre(){
        showsService.load(service: .listTVShowsBy(genreId) , decodeType: TVShowResult.self, completion: { result in
            switch result{
            case .success(let response):
                self.processFetched(for: response.results)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    //MARK: - Private
    private func processFetched(for shows: [TVShow]){
        print("\nSe recibieron : [\(shows.count) Shows]. Actualizar TableView")
        self.shows.append(contentsOf: shows)
        
        self.models = shows.map({
            return TVShowCellViewModel(show: $0)
        })
        self.viewState.value = .populated(shows)
    }
    
    //MARK: - Build Models
    func buildShowDetailViewModel(for showId: Int) -> TVShowDetailViewModel {
        return TVShowDetailViewModel(showId)
    }
}

extension TVShowListViewModel{
    
    enum ViewState {
        
        case loading
        case populated([TVShow])
        case empty
        case error(Error)
        
        var currentEpisodes : [TVShow] {
            switch self{
            case .populated(let episodes):
                return episodes
            default:
                return []
            }
        }
    }
}
