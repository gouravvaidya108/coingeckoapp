//
//  LocalFileManager.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import SwiftUI

final class LocalFileManager {
  // MARK: - Singleton Instance
  static let shared = LocalFileManager()

  // MARK: - Initialization
  private init() { }
}

// MARK: - Public Helper Methods
extension LocalFileManager {
  func saveImage(_ image: UIImage, imageName: String, folderName: String) {
    createFolderIfNeeded(folderName: folderName)

    guard
      let data = image.pngData(),
      let url = getURLForImage(imageName: imageName, folderName: folderName)
    else { return }

    do {
      try data.write(to: url)
    } catch let error {
      print("An error occurred while saving the image. Error description: \(error.localizedDescription)")
    }
  }

  func getImage(imageName: String, folderName: String) -> UIImage? {
    guard
      let url = getURLForImage(imageName: imageName, folderName: folderName),
      FileManager.default.fileExists(atPath: url.path)
    else { return nil }
    return UIImage(contentsOfFile: url.path)
  }
}

// MARK: - Private Helper Methods
private extension LocalFileManager {
  func getURLForFolder(folderName: String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
    return url.appendingPathComponent(folderName)
  }

  func getURLForImage(imageName: String, folderName: String) -> URL? {
    guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
    return folderURL.appendingPathComponent("\(imageName).png")
  }

  func createFolderIfNeeded(folderName: String) {
    guard let url = getURLForFolder(folderName: folderName) else { return }
    if !FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: .none)
      } catch let error {
        print("An error occurred while creating the folder. File name: \(folderName). \nError description: \(error.localizedDescription)")
      }
    }
  }
}
