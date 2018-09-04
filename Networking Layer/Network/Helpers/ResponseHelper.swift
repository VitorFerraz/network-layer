//
//  ResponseHelper.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation
import Alamofire
class ResponseHelper{
    private var request:URLRequest
    init(request:URLRequest) {
        self.request = request
    }
    
    @discardableResult
     func performRequest<T:Decodable>(decoder: JSONDecoder = JSONDecoder(), completion:@escaping (ResultHelper<T>)->Void) -> DataRequest {

        return Alamofire.request(request)
            .validate()
            .responseData(completionHandler: { (data) in
                NetworkLogger.log(request: self.request)
                DispatchQueue.main.async {
                    switch data.result {
                    case .success(let value):
                        guard let obj = try? decoder.decode(T.self, from: value) else {
                            completion(ResultHelper.error(ErrorAPI.invalidData))
                            return
                        }
                        if let response = data.response , let json = try? JSONSerialization.jsonObject(with: value, options: []) as? [String : Any]{
                            NetworkLogger.log(response: response,json: json)
                        }
                        completion(ResultHelper.success(data.response?.statusCode ?? 404, obj))
                    case .failure(let error):
                        completion(ResultHelper.error(error))
                    }
                }

            })
//        return Alamofire.request(request).validate()
//            .responseJSONDecodable (decoder: decoder){ (response: DataResponse<T>) in
//                NetworkLogger.log(request: self.request)
//                DispatchQueue.main.async {
//
//                    switch response.result{
//                    case .failure(let error):
//                        completion(ResultHelper.error(error))
//                    case .success(let value):
//                        completion(ResultHelper.success(response.response?.statusCode ?? 404, value))
//                    }
//                }
//        }
    }

}
