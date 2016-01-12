#### Swift Tests and Design


## Main.storyboard

Scenes:

Best Tenants - Signin
 -ViewController


Signup View Controller
 -SignupViewController



## AppDelegate.swift
```
Used to bootstrap app
```


## ViewController.swift
```
@IBOutlet weak var usernameSignIn: UITextField!

@IBOutlet weak var passwordSignIn: UITextField!

@IBAction func signin(sender: UIButton) { }
```


## getUserId.swift

--Commented out
```
import Foundation


// class with one method

class getService {

    // getUser method for making api call

    func getUser() {


        // set api path as string
        // set url as a NSURL
        // set session as a session thing

        let path = "https://housematey.herokuapp.com/users"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()


        // set a task that does not return value that takes data, response, error

        let task = session.dataTaskWithURL(url!) { (data: NSData?,
                                                    response: NSURLResponse?,
                                                    error: NSError?) -> Void in

            // Use SwiftyJSON to make an json object data

            let json = JSON(data: data!)

            // walk through json data and print entries

            var count = 0

            for (index, object) in json {

                //extract first and last name from each object

                let firstName = object["firstName"].stringValue
                let lastName = object["lastName"].stringValue

                //print first and last name

                count += 1
                print("user \(count): \(firstName, lastName)")


                //for one specific user

                //extract properties and connection arrays

                if firstName == "Mattia" && lastName == "Assogna" {
                    let id = object["_id"].stringValue
                    let properties = object["properties"]
                    let connections = object["connections"]
                    print("user searched: \(firstName), ID: \(id)")

                    //extract full name of connections

                    for (index, object) in connections {
                        let connection = object["fullName"]
                        print("User connections: \(connection)")
                    }

                    //extract properties

                    if properties.isEmpty {
                        print("No properties")

                    } else {

                        for (index, object) in properties {
                            print(object)
                        }
                    }
                }


            }

            //count number of users

            print("Tot users: \(count)")

        }

        task.resume()
    }


}
```

## createNewUser.swift
```
import Foundation

class createService {

    func createUser() {

        let postEndpoint: String = "https://housematey.herokuapp.com/users/"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let postParams : [String: AnyObject] = ["password": "testtest", "salt": "test2", "provider": "local", "username": "Jonny13", "firstName": "prova", "lastName": "lastNameProva"]


        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
            print(postParams)
        } catch {
            print("bad things happened")
        }



        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in

            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }

            // Read the JSON
            if let postString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("POST: " + postString)
//                self.performSelectorOnMainThread("updatePostLabel:", withObject: postString, waitUntilDone: false)
            }

        }).resume()

}



    func createProperty() {

        let postEndpoint: String = "https://housematey.herokuapp.com/properties"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let postParams: NSDictionary = ["post_code":"W8 5JA","street_name":"Gun Road","landlord_name":"Mr Fokker","landlord_contact_details":"555 777 999","property_type":"Flat","number_of_flatmates":5,"monthly_cost":200,"deposit_amount":200,"inclusive":false,"__v":0]

        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
            print(postParams)
        } catch {
            print("bad things happened")
        }

        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }

            // Read the JSON
            if let postString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("POST: " + postString)
                //                self.performSelectorOnMainThread("updatePostLabel:", withObject: postString, waitUntilDone: false)
            }

        }).resume()

    }

}
```

## editService.swift
```
import Foundation

class editService {

    func editUser() {

        let session = NSURLSession.sharedSession()
        let newPropertyPut: NSDictionary = ["firstName": "Ugo"]
        let path: String = "https://housematey.herokuapp.com/users/567846de7f47911100f5c4a0"
        let url = NSMutableURLRequest(URL: NSURL(string: path)!)
        url.HTTPMethod = "PUT"

        // set new post as HTTPBody for request
        url.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        do {
            url.HTTPBody = try NSJSONSerialization.dataWithJSONObject(newPropertyPut, options: NSJSONWritingOptions())
            print(newPropertyPut)

        } catch {
            print("bad things happened")
        }

        // Make the POST call and handle it in a completion handler
        let task = session.dataTaskWithRequest(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in

            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }

            // Read the JSON
            if let putString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("PUT: " + putString)

            }

        })
        task.resume()
    }

    func editProperty() {

        let session = NSURLSession.sharedSession()
        let newPropertyPut: NSDictionary = ["post_code": "W3 6GG"]
        let path: String = "https://housematey.herokuapp.com/properties/5678440f7f47911100f5c494"
        let url = NSMutableURLRequest(URL: NSURL(string: path)!)
        url.HTTPMethod = "PUT"

        // set new post as HTTPBody for request
        url.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        do {
            url.HTTPBody = try NSJSONSerialization.dataWithJSONObject(newPropertyPut, options: NSJSONWritingOptions())
            print(newPropertyPut)

        } catch {
            print("bad things happened")
        }

        // Make the POST call and handle it in a completion handler
        let task = session.dataTaskWithRequest(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in

            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }

            // Read the JSON
            if let putString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("PUT: " + putString)

            }

        })
        task.resume()
    }
}
```

## deleteService.swift
```
import Foundation

class deleteService {

    func deleteUser() {


                let deleteUser: String = "https://housematey.herokuapp.com/users/567840e77f47911100f5c48f"
                let deleteUserRequest = NSMutableURLRequest(URL: NSURL(string: deleteUser)!)
                deleteUserRequest.HTTPMethod = "DELETE"

                let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                let session = NSURLSession(configuration: config)

                let task = session.dataTaskWithRequest(deleteUserRequest, completionHandler: {
                    (data, response, error) in
                    guard let _ = data else {
                        print("error calling DELETE on /user")
                        return
                    }
                })
                task.resume()
            }


}
```

##  SignupViewController.swift
```
import UIKit

class SignupViewController: UIViewController {

    //outlet to basic user properties

    @IBOutlet weak var usernameSignUp: UITextField!
    @IBOutlet weak var firstnameSignUp: UITextField!
    @IBOutlet weak var lastnameSignUp: UITextField!
    @IBOutlet weak var emailSignUp: UITextField!
    @IBOutlet weak var passwordSignUp: UITextField!

    // no need for default override functions
    override func viewDidLoad() {
        super.viewDidLoad()


    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()


    }

    //Check all entries made

    @IBAction func signup(sender: UIButton) {
        let username:NSString = usernameSignUp.text!
        let firstname:NSString = firstnameSignUp.text!
        let lastname:NSString = lastnameSignUp.text!
        let email:NSString = emailSignUp.text!
        let password:NSString = passwordSignUp.text!

        if ( username.isEqualToString("") || firstname.isEqualToString("") || lastname.isEqualToString("") || email.isEqualToString("") || password.isEqualToString("") ) {

            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter account information"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()

        } else {
            do {
                //set up to make post

                let postEndpoint: String = "https://housematey.herokuapp.com/users/"
                let url = NSURL(string: postEndpoint)!
                let session = NSURLSession.sharedSession()
                let postParams : [String: AnyObject] = ["provider": "local", "username": username, "firstName": firstname, "lastName": lastname, "email": email,"password": password]


                // Create the request
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                do {
                    request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
                    print(postParams)
                } catch {
                    print("bad things happened")
                }

                // Make the POST call and handle it in a completion handler
                session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    // Make sure we get an OK response
                    guard let realResponse = response as? NSHTTPURLResponse where
                        realResponse.statusCode == 200 else {
                            print("Not a 200 response")
                            return
                    }

                    // Read the JSON
                    if let postString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                        // Print what we got from the call
                        print("POST: " + postString)
                        //                self.performSelectorOnMainThread("updatePostLabel:", withObject: postString, waitUntilDone: false)
                    }

                }).resume()
            }
        }
    }

}
```

