//
//  GenreCollectionView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 12/08/2026.
//

import SwiftUI

struct GenreCollectionView: View {
    let genre: Genre
    
    var body: some View {
        Label("Here will be movies of genre: \(genre.name)", systemImage: "film")
    }
}

#Preview {
    //GenreCollectionView(genre: Genre.sample)
    MainView()
}

@MainActor
@Observable
class MainViewViewModel {
    var username: String = ""
    var password: String = ""
    var magicNumber: Int = 0
    
    var isLoading = false
    var errorMessage: String?
    
    var loginUsecase = LoginUseCase(networkRepository: DefaultNetworkRepository())
    
    func add() {
        magicNumber += 1
    }
    
    func subtract() {
        magicNumber -= 1
    }
    
    func submit() {
        Task {
            do {
                try await loginUsecase.execute()
            } catch {
                errorMessage = error.localizedDescription
            }
            // do something
        }
    }
}

protocol NetworkRepository {
    func login(username: String, password: String) async throws
}

struct DefaultNetworkRepository: NetworkRepository {
    func login(username: String, password: String) async throws {
        try await Task.sleep(nanoseconds: 1000)
    }
}

struct LoginUseCase {
    let networkRepository: NetworkRepository
    
    init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }
    
    func execute() async throws {
        try await networkRepository.login(username: "a", password: "b")
    }
}

struct MainView: View {
    @State
    var viewModel = MainViewViewModel()
    
    var body: some View {
        Form {
            TextField("Username", text: $viewModel.username)
            SecureField("Password", text: $viewModel.password)
            Text("Number: \(viewModel.magicNumber)")
            Button("Add") {
                viewModel.add()
            }
            Button("Subtract") {
                viewModel.subtract()
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button("Submit") {
                viewModel.submit()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}
