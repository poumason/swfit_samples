//
//  ContentView.swift
//  DownloadAndReadApp
//
//  Created by POU LIN on 2024/2/21.
//

import SwiftUI
// https://github.com/weichsel/ZIPFoundation?tab=readme-ov-file#installation
import ZIPFoundation

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Download File") {
                let downloadPath = "http://127.0.0.1:5000/download"
                Task {
                    let url = await downloadFileDataTask(urlString: downloadPath)
                    if let url = url {
                        print(url)
                        let documentsUrl =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                        let targetDir = documentsUrl.appendingPathComponent("attachement.bundle")
                        
                        print(targetDir)
                        
                        do {
                            let fileManager = FileManager()
//                            try fileManager.removeItem(atPath: targetDir.absoluteString)
//                            try fileManager.unzipItem(at: url, to: documentsUrl)
                            
                            let fileURLs = try fileManager.contentsOfDirectory(atPath: targetDir.path)
                        
                            for item in fileURLs {
                                print(item)
//                                if "json" in item.
                                if item.contains(".json") {
                                    let jsonPath = targetDir.appendingPathComponent(item)
                                    let result = readJsonFile(file: jsonPath)
                                    print(result?.title ?? "")
                                }
                            }
                        } catch {
                            print("Extraction of ZIP archive failed with error:\(error)")
                        }
                    
                    }
                }
//                Task {
//                    let url = await downloadFileAsync(urlstring: downloadPath)
//                    if let url = url {
//                        print(url)
//                    }
//                }
//                downloadFileCompletionHandler(urlstring: "http://127.0.0.1:5000/download") { destinationUrl, error in
//                    if let url = destinationUrl {
//                        print(url)
//                    } else {
//                        print(error ?? "")
//                    }
//                }
            }
        }
        .padding()
    }
    
    private func downloadFileCompletionHandler(urlstring: String, completion: @escaping (URL?, Error?) -> Void) {

            let url = URL(string: urlstring)!
            let documentsUrl =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
            print(destinationUrl)

            if FileManager().fileExists(atPath: destinationUrl.path) {
                print("File already exists [\(destinationUrl.path)]")
    //            try! FileManager().removeItem(at: destinationUrl)
                completion(destinationUrl, nil)
                return
            }

            let request = URLRequest(url: url)


            let task = URLSession.shared.downloadTask(with: request) { tempFileUrl, response, error in
    //            print(tempFileUrl, response, error)
                if error != nil {
                    completion(nil, error)
                    return
                }

                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        if let tempFileUrl = tempFileUrl {
                            print("download finished")
                            try! FileManager.default.moveItem(at: tempFileUrl, to: destinationUrl)
                            completion(destinationUrl, error)
                        } else {
                            completion(nil, error)
                        }

                    }
                }

            }
            task.resume()
        }
    
    private func downloadTaskAsync(request: URLRequest) async  -> (URL?, URLResponse?, Error?) {
            
        return await withCheckedContinuation{ continuation in
            URLSession.shared.downloadTask(with: request) { tempFileUrl, response, error in
                continuation.resume(returning: (tempFileUrl, response, error))
            }.resume()
        }
    }
    
    private func downloadFileAsync(urlstring: String) async -> URL? {
            
            let url = URL(string: urlstring)!

            let documentsUrl =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
            print(destinationUrl)

            if FileManager().fileExists(atPath: destinationUrl.path) {
                print("File already exists [\(destinationUrl.path)]")
    //            try! FileManager().removeItem(at: destinationUrl)
                return destinationUrl
            }
            
            let request = URLRequest(url: url)
            let (tempFileUrl, response, error)  = await downloadTaskAsync(request: request)
            if error != nil {
                return nil
            }
                
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let tempFileUrl = tempFileUrl {
                        print("download finished")
                        try! FileManager.default.moveItem(at: tempFileUrl, to: destinationUrl)
                        return destinationUrl
                    } else {
                        return nil
                    }
                
                }
            }
            
            return nil
        }
    
    private func downloadFileDataTask(urlString: String) async -> URL? {

            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
           
            let (data, response)  = try! await URLSession.shared.data(for: request)
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("download finished")
                    let documentsUrl =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let destinationUrl = documentsUrl.appendingPathComponent(
//                        url.lastPathComponent +
                        response.suggestedFilename!)
                
                    
                    print(destinationUrl)
                    if FileManager().fileExists(atPath: destinationUrl.path) {
                        print("File already exists [\(destinationUrl.path)]")
            //            try! FileManager().removeItem(at: destinationUrl)
                        return destinationUrl
                    }
                    try! data.write(to: destinationUrl)
                    return destinationUrl
                }
                
                
            }
            return nil
        }
    
    private func readJsonFile(file: URL) -> DocItem? {
        do {
            let data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(DocItem.self, from: data)
            return jsonData
        } catch {
            print(error)
        }
        return nil
    }
}

#Preview {
    ContentView()
}
