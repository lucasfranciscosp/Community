//
//  FetchCommunityDelegate.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 28/08/23.
//

import Foundation

protocol FetchCommunityDelegate {
    func didFetchCommunities(communities: [Comunidade])
    func errorFetchingCommunities()
}

class CommunityDataManager {
    var community: [Comunidade] = []
    var delegate: FetchCommunityDelegate?
    
    
    func fetchCommunities() async {
        do {
            community = try await Comunidade.fetchNearCommunities()
            delegate?.didFetchCommunities(communities: community)
        } catch {
            delegate?.errorFetchingCommunities()
        }
    }
}
