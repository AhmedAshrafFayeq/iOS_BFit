//
//  BaseAPI.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation
import Alamofire

class BaseApi<T:TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, AFError>)-> Void){
        let method  = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params  = buildParams(task: target.task)
        AF.request(target.baseURL + target.path, method: method, parameters:params.0, encoding: params.1, headers: headers).responseDecodable { (response: DataResponse<M, AFError>) in
            
            print(target.baseURL + target.path)
            
            switch response.result {
            case .success(let jsonResponseObject):
                completion(.success(jsonResponseObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func buildParams(task: Task)-> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return([:], URLEncoding.default)
        case .requestParmeters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
