//
//  File.swift
//  File
//
//  Created by __________ on 05/11/2021.
//

import Foundation

extension DripKit {
    // MARK: - WinterOutfitsRawResponse
    public struct WinterOutfitsRawResponse: Codable {
        public let userID: Int
        public let outfits: [Outfit]

        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case outfits
        }
    }

    // MARK: - Outfit
    public struct Outfit: Codable {
        public let when, outfitDescription: String
        public let inspiredByPhotoURL: String
        public let occasion: String
        public let items: [Item]

        enum CodingKeys: String, CodingKey {
            case when
            case outfitDescription = "description"
            case inspiredByPhotoURL = "inspired_by_photo_url"
            case occasion, items
        }
    }

    // MARK: - Item
    public struct Item: Codable {
        public let name, brand: String
        public let stockLevel: StockLevel
        public let imageURL: String
        public let url, priceGbp: String
        public let priceGbpSince: Int
        public let pricePreviousGbp: String
        public let pricePreviousGbpSince: Int

        enum CodingKeys: String, CodingKey {
            case name, brand
            case stockLevel = "stock_level"
            case imageURL = "image_url"
            case url
            case priceGbp = "price_gbp"
            case priceGbpSince = "price_gbp_since"
            case pricePreviousGbp = "price_previous_gbp"
            case pricePreviousGbpSince = "price_previous_gbp_since"
        }
    }

    public enum StockLevel: String, Codable {
        case inStock = "in_stock"
        case outOfStock = "out_of_stock"
    }


}
