//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var viewModel: OnBoardingViewModel
    @EnvironmentObject var invite: Invite
    @StateObject var cloud = CloudKitModel.shared
    @State var validTextField = false
    @State var showingAlert = false
    @State private var pages: [OnBoarding] = OnBoarding.onboardingPages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        NavigationView{
            VStack {
                TabView(selection: $viewModel.onboardingPage) {
                    OnBoardingPageTypeOneView(onboarding: pages[0])
                        .tag(0)
                    OnBoardingPageTypeOneView(onboarding: pages[1])
                        .tag(1)
                    OnBoardingPageTypeTwoView(onboarding: pages[2], viewModel: _viewModel, validTextField: $validTextField)
                        .tag(2)
                        .gesture(viewModel.incomeTextField.isEmpty ? DragGesture() : nil)
                    OnBoardingPageTypeOneView(onboarding: pages[7])
                        .tag(3)
                    if invite.isSendInviteAccepted && invite.isReceivedInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[6])
                            .tag(4)
                    } else if invite.isSendInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[4])
                            .tag(4)
                    } else if invite.isReceivedInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[5])
                            .tag(4)
                    } else {
                        OnBoardingPageTypeOneView(onboarding: pages[3])
                            .tag(4)
                    }
                }
                .animation(.easeInOut, value: viewModel.onboardingPage)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(.page)
                Button {
                    if viewModel.onboardingPage != 4 {
                        viewModel.onboardingPage += 1
                        if !viewModel.incomeTextField.isEmpty {
                            let money = viewModel.incomeTextField.convertoMoneyToFloat()
                            UserDefault.setIncome(income: money)
                        }
                    } else {
                        if Invite.shared.isReady() {
                            let money = UserDefault.getIncome()
                            viewModel.initialPosts(income: money)
                        } else {
                            viewModel.sharingInvite()
                        }
                    }
                } label: {
                    Text(viewModel.onboardingPage == 4 && !(invite.isSendInviteAccepted && invite.isReceivedInviteAccepted ) ? (cloud.isShareNil ? "Carregando..." : "Compartilhar") : EnumButtonText.nextButton.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background((validTextField && viewModel.onboardingPage == 2) || viewModel.onboardingPage != 2 ?   Color(EnumColors.buttonColor.rawValue): .gray )
                        .cornerRadius(13)
                }
                .disabled(!validTextField && viewModel.onboardingPage == 2)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if viewModel.onboardingPage < 2 {
                        SkipButton(onboardingPage: $viewModel.onboardingPage, skipButton: EnumButtonText.skip.rawValue)
                    } else if viewModel.onboardingPage == 2 {
                        InfoButton(infoButton: "info.circle")
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    } else if viewModel.onboardingPage == 4 {
                        Button {
                            showingAlert.toggle()
                        } label: {
                            Text("Cancelar")
                        }
                        .alert("Deseja cancelar o compartilhamento?", isPresented: $showingAlert) {
                            Button(role: .cancel) { }
                        label: {
                            Text("Não")
                        }
                            Button("Sim") {
                                viewModel.deleteShare()
                            }
                        }
                        
                    }
                }
                
            }
            .padding(24)
            .background(Color(EnumColors.backgroundScreen.rawValue))
        }
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = UIColor(Color(EnumColors.dotAppearing.rawValue))
            dotAppearance.pageIndicatorTintColor = UIColor(Color(EnumColors.dotNotAppearing.rawValue))
            validTextField = viewModel.incomeTextField.isEmpty ? false : true
        }
    }
}
