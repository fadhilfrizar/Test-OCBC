//
//  BaseApiManager.swift
//  OSBC Test
//
//  Created by frizar fadilah on 19/05/22.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift
import RxSwift
import Alamofire

// Class will be used to handle api response from server
class BaseApiManager {
    static let instance = BaseApiManager()
    var sessionManager = Alamofire.SessionManager()
    var configuration = URLSessionConfiguration.default
    
    // MARK: Request Handler from Alamofire
    // Create API Request
    // After get responses object from server,
    // then mapping into mappable class with ObjectMapper Library.
    // This class can use in other class when you need to get request from server.

    func apiGetRequest<T: Decodable> (
        url: String,
        method: HTTPMethod,
        headers: HTTPHeaders?,
        parameters: Parameters?,
        encoding: ParameterEncoding) -> Observable<T> {
        
        configuration.timeoutIntervalForRequest = 60
        configuration.httpAdditionalHeaders = headers
                
        return Observable<T>.create { observer in
            // Alamofire request url, method, and the result is responseObject
            let request = self.sessionManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate(statusCode: 200..<401).responseDecodable { (response: DataResponse<T>) in
                                
                let status = response.response?.statusCode
                switch response.result {
                // if success the response will be include in success callback
                case .success(let value):
                    if status == 200 {
                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            debugPrint("API Response: \(utf8Text)")
                        }
                        observer.onNext(value)
                        observer.onCompleted()
                    } else {
                        if let response = response.response {
                            switch response.statusCode {
                            case 400:
                                observer.onError(Const.ApiError.badRequest)
                            case 401:
                                observer.onError(Const.ApiError.session)
                            case 403:
                                observer.onError(Const.ApiError.forbidden)
                            case 404:
                                observer.onError(Const.ApiError.notFound)
                            case 409:
                                observer.onError(Const.ApiError.conflict)
                            case 422:
                                observer.onError(Const.ApiError.responseValidationFailed)
                            case 500:
                                observer.onError(Const.ApiError.internalServalError)
                            case 0:
                                observer.onError(Const.ApiError.lostConnection)
                            default:
                                observer.onError(Const.ApiError.lostConnection)
                            }
                        }
                    }
                    
                    
                // if fail, will be show message error
                case .failure(let error):
                    if let data = response.data {
                        print("response data error", String(data: data, encoding: .utf8)!)
                    }
                    if let response = response.response {
                        switch response.statusCode {
                        case 400:
                            observer.onError(Const.ApiError.badRequest)
                        case 401:
                            observer.onError(Const.ApiError.session)
                        case 403:
                            observer.onError(Const.ApiError.forbidden)
                        case 404:
                            observer.onError(Const.ApiError.notFound)
                        case 409:
                            observer.onError(Const.ApiError.conflict)
                        case 422:
                            observer.onError(Const.ApiError.responseValidationFailed)
                        case 500:
                            observer.onError(Const.ApiError.internalServalError)
                        case 0:
                            observer.onError(Const.ApiError.lostConnection)
                        default:
                            observer.onError(error)
                        }
                        
                    }
                    
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    
    func cancelAllRequest() {
        self.sessionManager.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            print("session queued: ")
            print(sessionDataTask)
            print(uploadData)
            print(downloadData)
            
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}


extension DataRequest {
    
    enum DataResponseDecodableError: Error {
        case responseDataIsEmpty
    }
    
    @discardableResult
    public func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil,
                                                completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue) { response in
            
            var result: Result<T>
            defer {
                let dataResponse = DataResponse(request: response.request,
                                                response: response.response,
                                                data: response.data,
                                                result: result,
                                                timeline: response.timeline)
                completionHandler(dataResponse)
            }
            
            guard let data = response.data else {
                result = .failure(DataResponseDecodableError.responseDataIsEmpty)
                return
            }
            do {
                print(String(decoding: data, as: UTF8.self))
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let codable = try decoder.decode(T.self, from: data)
                result = .success(codable)
            } catch {
                result = .failure(error)
            }
        }
    }
}
