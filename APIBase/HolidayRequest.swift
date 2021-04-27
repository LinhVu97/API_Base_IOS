//
//  HolidayRequest.swift
//  APIBase
//
//  Created by Vũ Linh on 27/04/2021.
//

import Foundation

enum HolidayError: Error {
    case noDataAvailable
    case cannotProcessData
}

struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "306ce05c8f38c6f9b9ee1e064380ce5705383495"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping (Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, _) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidaysDetail = holidayResponse.response.holidays
                completion(.success(holidaysDetail))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        
        dataTask.resume()
    }
}
