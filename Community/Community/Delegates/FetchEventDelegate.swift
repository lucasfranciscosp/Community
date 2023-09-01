//
//  FetchEventDelegate.swift
//  events
//
//  Created by Caio Melloni dos Santos on 01/09/23.
//

import Foundation

protocol FetchEventDelegate {
    func didInitialFetchEvents(events: [Evento])
    func didRefreshEvents(events: [Evento])
    func errorFetchingEvents()
}

class EventDataManager {
    private var events: [Evento] = []
    var delegate: FetchEventDelegate?
    var eventsArray: [Evento] {
        return events
    }
    
    
    private func fetchEventsInternal() async {
        do {
            events = try await Evento.fetchNearEvents()
            DispatchQueue.main.async {
                self.delegate?.didInitialFetchEvents(events: self.events)
            }
        } catch {
            delegate?.errorFetchingEvents()
        }
    }
    
    private func refreshEventsInternal() async {
        do {
            events = try await Evento.fetchNearEvents()
            DispatchQueue.main.async {
                self.delegate?.didRefreshEvents(events: self.events)
            }
        } catch {
            delegate?.errorFetchingEvents()
        }
    }
    
    //MARK: - funcoes de casca
    func fetchEvents() {
        Task.detached(priority: .high) {
            await self.fetchEventsInternal()
        }
    }
    
    func refreshEvents() {
        Task.detached(priority: .high) {
            await self.refreshEventsInternal()
        }
    }
}
