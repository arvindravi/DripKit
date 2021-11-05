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
        let userID: Int
        let outfits: [Outfit]

        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case outfits
        }
    }

    // MARK: - Outfit
    public struct Outfit: Codable {
        let when, outfitDescription: String
        let inspiredByPhotoURL: String
        let occasion: String
        let items: [Item]

        enum CodingKeys: String, CodingKey {
            case when
            case outfitDescription = "description"
            case inspiredByPhotoURL = "inspired_by_photo_url"
            case occasion, items
        }
    }

    // MARK: - Item
    public struct Item: Codable {
        let name, brand: String
        let stockLevel: StockLevel
        let imageURL: String
        let url, priceGbp: String
        let priceGbpSince: Int
        let pricePreviousGbp: String
        let pricePreviousGbpSince: Int

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
