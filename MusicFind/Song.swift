//
//  Song.swift
//  MusicFind
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 maurisoft. All rights reserved.
//

import Foundation
import SwiftyJSON

class Song {

  var artistName : String!
  var songName : String!
  var albumName : String!
  var genre : String!
  var albumPrice: String!
  var currency: String!
  var imageUrl : NSURL!
  var previewUrl : NSURL!
  var realeaseDate : NSDate!

  func songInformation() -> String {
    return "\(artistName) - \(albumName)"
  }

  func priceInformation() -> String {
    return "Precio: \(albumPrice) \(currency)"
  }

  func genreInformation() -> String {
    return "Género: \(genre)"
  }

  class func songByJSON(json : JSON) -> Song {
    let song = Song()
    song.artistName = json["artistName"].stringValue
    song.albumName = json["collectionName"].stringValue
    song.songName = json["trackName"].stringValue
    song.genre = json["primaryGenreName"].stringValue
    song.albumPrice = json["collectionPrice"].stringValue
    song.currency = json["currency"].stringValue
    song.imageUrl = json["artworkUrl100"].URL
    song.previewUrl = json["previewUrl"].URL

    return song
  }

  class func songsByJSON(json : JSON) -> [Song] {
    var songs = [Song]()
    for songDictionary in json.arrayValue {
      let song = Song.songByJSON(songDictionary)
      songs.append(song)
    }
    return songs
  }
  
}


