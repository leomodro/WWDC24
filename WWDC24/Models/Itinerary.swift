//
//  Itinerary.swift
//  WWDC24
//
//  Created by Leonardo Modro on 16/06/25.
//

import Foundation
import FoundationModels

@available(iOS 26.0, *)
@Generable
struct Itinerary: Equatable {
    @Guide(description: "An exciting name for the trip.")
    let title: String
    @Guide(.anyOf(["San Francisco", "Dallas", "Paris", "Berlin"]))
    let destinationName: String
    let description: String
    @Guide(description: "An explanation of how the itinerary meets the user's special requests.")
    let rationale: String
    
    @Guide(description: "The list of day-by-day plans.")
    @Guide(.count(3))
    let days: [DayPlan]
}

@available(iOS 26.0, *)
struct DayPlan: Equatable {
    @Guide(description: "An unique and exciting title for this day plan.")
    let title: String
    let subtitle: String
    let destination: String
    
    @Guide(.count(3))
    let activities: [Activity]
}

struct Activity: Equatable {
    let type: ActivityType
    let title: String
    let description: String
}

enum ActivityType: String, CaseIterable {
    case sightseeing
    case foodAndDining
    case shopping
    case hotelAndLogdging
}
