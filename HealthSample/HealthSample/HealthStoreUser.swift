//
//  HealthStoreUser.swift
//  HealthSample
//
//  Created by Mahadevan, Ramesh on 10/19/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import Foundation
import HealthKit

@objc protocol HealthStoreUser {
    var healthStore: HKHealthStore? { get set }
}