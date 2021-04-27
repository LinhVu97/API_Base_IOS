//
//  Holidays.swift
//  APIBase
//
//  Created by Vũ Linh on 27/04/2021.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var description: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}
