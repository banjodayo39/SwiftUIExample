//
//  LogInScreen.swift
//  WeatherApp
//
//  Created by Home on 1/18/21.
//

import SwiftUI

struct LogInScreen: View {
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        NavigationView{
            VStack{
                
                Text("Movie App").font(.title).bold().foregroundColor(.blue).padding(.bottom, 50)
                
                Divider().padding(.bottom)
                
                
                TextField("Email/Phone Number", text: $username)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.blue, lineWidth: 1))
                
                
                SecureField("Password", text: $username)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.blue, lineWidth: 1))
                    .padding(.top, 20)
                

                
                    NavigationLink(
                        destination: MovieView(),
                        label: {
                            Text("Log in").foregroundColor(Color.white).bold()
                                .frame(width: UIScreen.main.bounds.width - 100, height: 48,  alignment: .center)
                                .background(Color.blue)
                                .cornerRadius(10)
                        })
                        .padding(.top, 50)
            
                
                Spacer()
                
            }.padding(50)

        }
        
    }
    
    func initLogInUsingKeyChain(){
        let pwd = "name"
        if let paswd = SecureMgr.retrievePassword(username: "username"){
            if pwd  != paswd{
                // don't autheticate user 
            }
        } else {
            //Store Login : put them newly in keychain
        }
    }
    
    func retrievePassword(){
        let pasword = SecureMgr.retrievePassword(username: "Username")
    }
    
    func storeLogInServer(){
        let store = SecureMgr.storeInternetData(username: "dayo", password: "password", server: "www.usernmae.com", userType: "admin")
    }
    
    func logIn(_ username: String, _ password : String){
        //on success store login in Keychain
        let store = SecureMgr.storeLogin(username: username, password: password)
        print("Log in was \(store ? "" : "NOT") stored")
        
        UserDefaults.standard.setValue(true, forKey: "LOGGEDIN")
        
    }
    
    func addNoteToKeyChain(){
        let note = Note(uuid: "uiiioo", text: "This coding sweet me die pass elect wey I get firct class on top")
        let _ = SecureMgr.storeItem(uuid: note.uuid, note: note.text)
    }
}

struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
