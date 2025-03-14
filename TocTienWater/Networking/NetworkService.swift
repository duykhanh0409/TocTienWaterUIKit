//
//  NetworkService.swift
//  IOS-Challenge
//
//  Created by Nhat on 12/12/24.
//

import Foundation
import Combine

// MARK: - Enums


enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case encodingFailed
    case serverError(statusCode: Int)
    case noData
    case unauthorized
    case networkConnectionError
    case missingURL
    case other(message: String)
}

// MARK: - Protocols
protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ router: EndPointType) -> AnyPublisher<T, Error>
    

    func requestRawData(
        _ router: EndPointType
    ) -> AnyPublisher<Data, Error>
}

// MARK: - Network Service
class NetworkService: NetworkServiceProtocol {
    // Singleton instance
    static let shared = NetworkService()

    private let session: URLSession
    // Prevent direct initialization
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.requestCachePolicy = .useProtocolCachePolicy
        self.session = URLSession(configuration: configuration)
    }

    // MARK: - Request with Decoding
    func request<T: Decodable>(_ router: EndPointType) -> AnyPublisher<T, Error> {
        do {
            let urlRequest = try self.buildRequest(from: router)
            
            return performRequest(urlRequest)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    // MARK: - Raw Data Request
    func requestRawData(_ router: EndPointType) -> AnyPublisher<Data, Error> {
        do {
            // Build URLRequest
            let urlRequest = try self.buildRequest(from: router)

            // Perform request
            return performRequest(urlRequest)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    // MARK: - Private Helper Methods
    private func performRequest(_ urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error -> Error in
                switch error.code {
                case .notConnectedToInternet, .timedOut:
                    return NetworkError.networkConnectionError
                default:
                    return NetworkError.requestFailed
                }
            }
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.requestFailed
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    guard !data.isEmpty else {
                        throw NetworkError.noData
                    }
                    return data
                case 401:
                    throw NetworkError.unauthorized
                case 400...499, 500...599:
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                default:
                    throw NetworkError.requestFailed
                }
            }
            .eraseToAnyPublisher()
    }
}

extension NetworkService {
    private func buildRequest(from endPoint: EndPointType) throws -> URLRequest {
        let url = endPoint.path != "" ? endPoint.baseURL.appendingPathComponent(endPoint.path) : endPoint.baseURL
        
        var request = URLRequest(url: url, timeoutInterval: endPoint.timeoutInterval ?? 30.0)
        request.httpMethod = endPoint.method.rawValue
        
        endPoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        do {
            switch endPoint.task {
                
            case .request:
                request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            case .requestParameters(let bodyParameters,
                                    let urlParameters,
                                    let parameterEncoding):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             parameterEncoding: parameterEncoding,
                                             request: &request)
            case .requestParametersAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let additionHeaders,
                                              let parameterEncoding):
                
                self.addAdditionalHeaders(additionHeaders, request: &request)
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             parameterEncoding: parameterEncoding,
                                             request: &request)
            case .requestMultiPart(let bodyParameters,
                                   let urlParameters,
                                   let additionHeaders,
                                   let parameterEncoding):
                
                self.addAdditionalHeaders(additionHeaders,
                                          request: &request)
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             parameterEncoding: parameterEncoding,
                                             request: &request)
               
            }
        }
        return request
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func configureParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        parameterEncoding: ParameterEncoding,
        request: inout URLRequest
    ) throws {
        do {
            try parameterEncoding.encode(from: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    func configureParameters(
        bodyParameters: MultipartFormData,
        urlParameters: Parameters?,
        parameterEncoding: ParameterEncoding,
        request: inout URLRequest
    ) throws {
        do {
            try parameterEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters)
        } catch {
            throw error
        }
    }
}
