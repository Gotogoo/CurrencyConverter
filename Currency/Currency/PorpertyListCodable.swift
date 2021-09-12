//
//  PorpertyListCodable.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/12.
//

import Foundation

protocol PorpertyListCodable {
  associatedtype Model: Codable

  static var fileName: String { get }
}

extension PorpertyListCodable {
  static func loadPropertyList() -> Model? {
    do {
      let data = try Data(contentsOf: fileURL)
      return try PropertyListDecoder().decode(Model.self, from: data)
    } catch {
      debugPrint(error)
      return nil
    }
  }

  static func savePropertyList(model: Model) {
    do {
      try PropertyListEncoder().encode(model).write(to: fileURL)
    } catch {
      debugPrint(error)
    }
  }

  private static var fileURL: URL {
    guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
      fatalError("Could not access document directory!")
    }
    let fileURL = documentDirectoryURL.appendingPathComponent(fileName)
    if !FileManager.default.fileExists(atPath: fileURL.relativePath) {
      createDocument(fileURL)
    }
    return fileURL
  }

  private static func createDocument(_ documentUrl: URL) {
    do {
      guard let bundlePath = Bundle.main.path(forResource: fileName, ofType: "") else {
        fatalError("PList file \(fileName) not existed!")
      }
      let bundleURL = URL(fileURLWithPath: bundlePath)
      try FileManager.default.copyItem(at: bundleURL, to: documentUrl)
    } catch {
      debugPrint(error)
    }
  }
}


