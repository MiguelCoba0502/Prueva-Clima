//
//  ServiceManager.swift
//  Prueva Clima
//
//  Created by Eduardo Coba on 05/11/24.
//

import Foundation

protocol ServiceProtocol {
    func resquest<T:Codable>(request: URLRequest) async throws -> T
}


enum APIError: Error, LocalizedError,Equatable {
    case failed
    case faieldToDecode
    case unknownError
    case server(error: String)

    var errorDescription: String? {
        switch self {
        case .failed:
            return NSLocalizedString( "failed",comment: "")
        case .faieldToDecode:
            return NSLocalizedString( "faieldToDecode",comment: "")

        case .unknownError:
            return NSLocalizedString( "unknownError",comment: "")
        case .server(let error):
            return NSLocalizedString(error.description, comment: "")
        }
    }
}

final class RemoteServiceManager:ServiceProtocol {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
      self.urlSession = urlSession
    }
    
    func resquest<T>(request: URLRequest) async throws -> T  where T : Codable {
        let request = try await urlSession.data(for: request)
        guard let httpResponse = request.1 as? HTTPURLResponse
        else { throw APIError.unknownError }
        print(httpResponse.statusCode)
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: request.0)
        return model
    }
}
