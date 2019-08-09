//
//  HotelModelViewModel.swift
//  Hurb
//
//  Created by Alexandre Papanis on 08/08/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HotelViewModel {
    //MARK: - Variables
    private let hotel: Hotel
    
    
    
    //MARK: - Init
    init(_ hotel: Hotel) {
        self.hotel = hotel
    }
    
    //MARK: - Hotel properties
    var name: String {
        return hotel.name ?? ""
    }
    
    var stars: Int? {
        return hotel.stars
    }
    
    var cityState: String {
        if let address = hotel.address {
            return "\(address.city ?? ""), \(address.state ?? "")"
        }
        return ""
    }
    
    var description: String {
        return hotel.description ?? hotel.smallDescription ?? ""
    }
    
    var imageUrl: URL? {
        if let image = hotel.image {
            return URL(string: image)
        }
        return nil
    }
    
    var isFreeCancellation: Bool {
        return hotel.huFreeCancellation ?? false
    }
    
    var amenities: [Amenity] {
        return hotel.amenities ?? []
    }
    
    var priceDescription: String {
        if let isHotel = hotel.isHotel {
            return isHotel ? "Diárias a partir de" : "A partir de"
        }
        return "A partir de"
    }
    
    var price: String {
        if let price = hotel.price {
            if let currentPrice = price.currentPrice {
                return Utils.convertDoubleToCurrencyString(number: currentPrice)
            }
        }
        return ""
    }
}
