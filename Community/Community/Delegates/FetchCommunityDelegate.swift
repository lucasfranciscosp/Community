//
//  FetchCommunityDelegate.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 28/08/23.
//

import Foundation

protocol FetchCommunityDelegate {
    func didInitialFetchCommunities(communities: [Comunidade])
    func didRefreshCommunities(communities: [Comunidade])
    func errorFetchingCommunities()
}

class CommunityDataManager {
    private var community: [Comunidade] = []
    var delegate: FetchCommunityDelegate?
    var communitiesArray: [Comunidade] {
        return community
    }
    
    
    private func fetchCommunitiesInternal() async {
        do {
            community = try await Comunidade.fetchNearCommunities()
            DispatchQueue.main.async {
                self.delegate?.didInitialFetchCommunities(communities: self.community)
            }
        } catch {
            delegate?.errorFetchingCommunities()
        }
    }
    
    private func refreshCommunitiesInternal() async {
        do {
            community = try await Comunidade.fetchNearCommunities()
            DispatchQueue.main.async {
                self.delegate?.didRefreshCommunities(communities: self.community)
            }
        } catch {
            delegate?.errorFetchingCommunities()
        }
    }
    
    //MARK: - funcoes de casca
    func fetchCommunities() {
        Task.detached(priority: .high) {
            await self.fetchCommunitiesInternal()
        }
    }
    
    func refreshCommunities() {
        Task.detached(priority: .high) {
            await self.refreshCommunitiesInternal()
        }
    }
}
