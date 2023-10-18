//
//  UPTTabBatProtocol.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 11.10.2023.
//

import Foundation

protocol UPTTabBarProtocol: AnyObject {
    func pressPlay()
    func pressPause()
    func pressNextTimePeriod()
    func pressRefresh()
    func pressLeftItem()
    func pressRightItem()
}
