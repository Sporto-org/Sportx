//
//  APIManager.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 08/05/2026.
//

import Foundation
final class APIManager {

    static let shared = APIManager()

    private init() {}

    func request<T: Decodable>(
        endpoint: SportsEndpoint,
        responseModel: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {

        let url = API.baseURL + endpoint.path

        AF.request(
            url,
            method: .get,
            parameters: endpoint.parameters
        )
        .validate()
        .responseDecodable(of: T.self) { response in

            switch response.result {

            case .success(let data):
                completion(.success(data))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension APIManager {

    func fetchSports(
        completion: @escaping (Result<[Sport], AFError>) -> Void
    ) {

        request(
            endpoint: .sports,
            responseModel: SportsResponse.self
        ) { result in

            switch result {

            case .success(let response):
                completion(.success(response.result ?? []))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchLeagues(
        sport: String,
        completion: @escaping (Result<[League], AFError>) -> Void
    ) {

        request(
            endpoint: .leagues(sport: sport),
            responseModel: LeaguesResponse.self
        ) { result in

            switch result {

            case .success(let response):
                completion(.success(response.result ?? []))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchTeams(
        sport: String,
        leagueId: Int,
        completion: @escaping (Result<[Team], AFError>) -> Void
    ) {

        request(
            endpoint: .teams(sport: sport, leagueId: leagueId),
            responseModel: TeamsResponse.self
        ) { result in

            switch result {

            case .success(let response):
                completion(.success(response.result ?? []))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchFixtures(
        sport: String,
        leagueId: Int,
        completion: @escaping (Result<[Fixture], AFError>) -> Void
    ) {

        request(
            endpoint: .fixtures(sport: sport, leagueId: leagueId),
            responseModel: FixturesResponse.self
        ) { result in

            switch result {

            case .success(let response):
                completion(.success(response.result ?? []))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
