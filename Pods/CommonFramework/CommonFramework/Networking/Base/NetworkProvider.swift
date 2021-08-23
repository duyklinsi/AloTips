//
//  NetworkProvider.swift
//  TableviewSample
//
//  Created by admin on 2021/04/02.
//

import Foundation
import Moya

public typealias MultiTarget = Moya.MultiTarget

// Enable debug in scheme debug
#if DEBUG
var loggingEnabled: Bool = true
#else
var loggingEnabled: Bool = false
#endif

protocol NetworkingType {
    associatedtype Target: TargetType
    var provider: OnlineProvider { get }
    
    static func defaultNetworking() -> Self
    static func stubbingNetworking() -> Self
}

/// - OnlineProvider
/// Make request to server
final class OnlineProvider {
    fileprivate let online: Bool
    fileprivate let provider: MoyaProvider<MultiTarget>

    init(endpointClosure: @escaping MoyaProvider<MultiTarget>.EndpointClosure = MoyaProvider<MultiTarget>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<MultiTarget>.RequestClosure = MoyaProvider<MultiTarget>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<MultiTarget>.StubClosure = MoyaProvider<MultiTarget>.neverStub,
         session: Session = MoyaProvider<MultiTarget>.defaultAlamofireSession(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Bool = true) {
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }

    /// Request api function  from the given components.
    ///
    /// - Parameters:
    ///     - target: Target API
    ///     - type:  type for encode
    ///     - completion: return value from server
    public func request<T: Codable>(_ target: MultiTarget, type: T.Type, completion: @escaping (Result<T?, BaseAPIError>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                // When call api success
                if (200...299).contains(response.statusCode) {
                    guard let results = try? JSONDecoder().decode(BaseAPIResponse<T>.self, from: response.data) else {
                        // Decode error
                        completion(.failure(BaseAPIError.parseResponseDataFalse(title: target.path)))
                        return
                    }
                    
                    // When error from response JSON
                    if let status = results.status, !status {
                        DispatchQueue.main.async {
                            completion(.failure(BaseAPIError.errorOfResponse(title: "Warning", message: results.message ?? "", code: results.code ?? "")))
                        }
                        return
                    }
                                
                    DispatchQueue.main.async {
                        completion(.success(results.data))
                    }
                } else {
                    // When call API error
                    let error = NSError(domain: target.path, code: response.statusCode, userInfo: nil)
                    completion(.failure(BaseAPIError.requestError(title: target.path, message: error.localizedDescription)))
                }
            case .failure(let error):
                let error = NSError(domain: target.path, code: error.errorCode, userInfo: nil)
                completion(.failure(BaseAPIError.requestError(title: target.path, message: error.localizedDescription)))
            }
        }
    }

}

/// The network layer for call API. we can use test with 'stubbingNetworking' or real API call with 'defaultNetworking'
public struct NetworkProvider: NetworkingType {
    typealias Target = MultiTarget
    let provider: OnlineProvider

    /// Default network  call
    static public func defaultNetworking() -> Self {
        return NetworkProvider(provider: newProvider(plugins))
    }

    /// testing network call
    static public func stubbingNetworking() -> Self {
        return NetworkProvider(provider: OnlineProvider(endpointClosure: endpointsClosure(),
                                                          requestClosure: NetworkProvider.endpointResolver(), stubClosure: MoyaProvider.immediatelyStub, online: true))
    }

    /// actual request api function
    /// - Parameters:
    /// - T: Target API
    /// - type: type for encode
    /// - completion: return value from server
    public func request<T: Codable>(_ target: MultiTarget, type: T.Type, completion:@escaping (Result<T?, BaseAPIError>) -> Void) {
        let actualRequest: () = self.provider.request(target, type: T.self, completion: completion)
        return actualRequest
    }


}

extension NetworkingType {
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }

    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }

    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        if loggingEnabled == true {
            plugins.append(NetworkLoggerPlugin())
        }
        return plugins
    }

    static func endpointResolver() -> MoyaProvider<Target>.RequestClosure {        

        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

private func newProvider(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider {
    return OnlineProvider(endpointClosure: NetworkProvider.endpointsClosure(xAccessToken),
                          requestClosure: NetworkProvider.endpointResolver(),
                          stubClosure: NetworkProvider.APIKeysBasedStubBehaviour,
                          plugins: plugins)
}

