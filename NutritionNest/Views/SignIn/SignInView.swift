//
//  SignInView.swift
//  NutritionNest
//
//  Created by Pedro Ésli Vieira do Nascimento on 20/09/23.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        ZStack {
            Color.asset.background
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text(Localization.LogIn.title)
                    .font(.custom.inter.font(size: 25, relativeTo: .title))
                    .bold()
                    .padding(.top, 32)
                Text(Localization.LogIn.message)
                    .font(.custom.inter.font(size: 15, relativeTo: .subheadline))
                    .foregroundColor(.asset.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.horizontal, 30)
                TextField("", text: $viewModel.email, prompt: Text(Localization.LogIn.Prompt.email))
                    .primaryTextFieldStyle()
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding(.top, 47)
                SecureField("", text: $viewModel.password, prompt: Text(Localization.LogIn.Prompt.password))
                    .primaryTextFieldStyle()
                    .padding(.top, 16)
                Text(viewModel.errorMessage)
                    .font(.custom.inter.font(size: 13, relativeTo: .footnote))
                    .opacity(viewModel.showErrorMessage ? 1 : 0)
                    .foregroundColor(.red)
                    .frame(height: 13)
                    .padding(.top, 10)
                SmallRoundButton(title: Localization.LogIn.Button.logIn) {
                    viewModel.signIn()
                }
                .padding(.top, 10)
                OrText()
                .padding(.top, 32)
                HStack(spacing: 9) {
                    ProviderButton(image: .assets.logos.facebookLogo) {
                        viewModel.signInFacebook()
                    }
                    ProviderButton(image: .assets.logos.googleLogo) {
                        viewModel.signInGoogle()
                    }
                    ProviderAppleButton { request in
                        viewModel.configureAppleSignInRequest(request: request)
                    } onCompletion: { result in
                        viewModel.signInApple(result: result)
                    }
                }
                .padding(.top, 22)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}