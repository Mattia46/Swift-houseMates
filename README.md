# Tenant-App

### User Stories - Listed in order of importance

##### 1 - Profiles
- Creating and displaying user profiles.
- Two types of profile display:
 - SUMMARY for public profile with summary of user's employment, rental resume and interests.  For example, 'No picture', Pastry chef (female 20 -30) working in Zone 1 living in Zone 2 sharing house paying £500-800 pcm with 4-5 year rental history covering house and flat shares.  WANTED any Zone 2 to 4 location house or flat £400-800 pcm.  Deposit no more than £800. One month notice. Interests heavy metal and skiing.  If OFFERING then also include property details and other sharers profiles but maybe this is phase II.
 - DETAILED for connections (people that are proposing to share accomodation). 

 - For example:
  * Potrait profile picture
  * Profile description 'age', relationship status, nationality/languages, bio (max 100 words)
   * Summary of work history from linkedin / entered by user, include work locations.
   * Current accommodation details, address, rent, deposit, notice, how many sharers, property type, landlord reference or contact details.
   * Rental history details (last 3 years), rent, address, how many sharers, property type, landlord reference or contact.
   * Interests, qualifications, memberships
   * More pictures.

##### 2 - GPS Search
- Map users by current location. Aim to visualise unfimilar location using map.

##### 3 - Document Store 
- Facilitate document storage for the user.

##### 4 - Messaging
- Allow tenants to to be able to communicate with other tenants.

##### 5 - Profile Search 
- Map users by targeted area (can be split into Search v1.0 and v2.0).

##### 6 - Recommendations 
- Review other user's profiles.

##### 7 - Endorsements 
- Endorse other user's profiles.

##### 8 - Account 
- Can only view other profiles after having signed up.

##### 9 - Guide 
- Provide guidance on how to be a successful tenant.

##### 10 - Wall 
- Tenants can share info on their own space/wall.

##### 11 - Knowledgebase 
- Tenants knowledgebase for renting.

##### UPDATE:
- Connections: Users can 'connect' with each other, which allows a user to leave recommendations and endorsements.
- 

**Backend Hello World**

Three options for ios backend:
 1. [Firebase](https://www.firebase.com/docs/ios/examples.html) 
 2. NodeJS:
  1. [How to Write An iOS App that Uses a Node.js/MongoDB Web Service](http://www.raywenderlich.com/61264/write-ios-app-uses-node-jsmongodb-web-service)
  2. [Mobile Developers – Easily Build a Backend REST API with Node.js](http://www.iosinsight.com/backend-rest-api-nodejs/)
 3. [Parse](https://parse.com/docs/ios/guide)
 4. 
 

##### Data Model
```
var PropertySchema = new Schema ({

  location_area: String,

  post_code: String,

  street_name: String,

  landlord_name: String,

  landlord_contact_details: String,

  contract_start: Date,

  contract_end :Date,

  property_type: String,

  number_of_flatmates: Number,

  monthly_cost: Number,

  deposit_amount: Number,

  inclusive: Boolean

});


var UserSchema = new Schema({

    firstName: String,

    lastName: String,

    email: {
              type: String,
              match: [/.+\@.+\..+/,
              "Please fill a valid e-mail address"]
    },
    username: {
              type: String,
              trim: true,
              required: 'Username is required',
              unique: true
    },
    password: {
              type: String,
              validate: [
              function(password) {
                return password && password.length > 6;
              },
              'Password should be longer']
    },
    salt: {type: String},

    provider: {type: String, required: 'Provider is required'},

    providrId: String,

    providerData: {},

    created: {type: Date, default: Date.now},

    profile_picture: String,

    properties: [{ type: Schema.Types.ObjectId, ref: 'Property', autopopulate: true }],

    connections: [{ type: Schema.Types.ObjectId, ref: 'User', autopopulate: {select: '-connections -requests_sent -requests_recd -password -salt'} }],

    requests_sent: [{ type: Schema.Types.ObjectId, ref: 'User', autopopulate: {select: '-connections -requests_sent -requests_recd -password -salt'} }],

    requests_recd: [{ type: Schema.Types.ObjectId, ref: 'User', autopopulate: {select: '-connections -requests_sent -requests_recd -password -salt'} }],

    currentArea: String,

    currentRentBand: Number,

    currentNoticePeriodDays: Number

  });
```

***Suggested API Calls***
```
/users                                          :list of all users - DONE GET, POST
/properties                                     :list of all properties - DONE GET, POST
/users/user_id                                  :user object for specific id - DONE GET, UPDATE, DELETE
/properties/property_id                         :project object for specific id - DONE GET, UPDATE, DELETE
/users_properties/user_id                       :list of properties for a specific user - DONE GET
```
Note: to add a user you must signup user on https://housematey.herokuapp.com/signup with First and last name, username and password.  Please use the username as password to make testing easier.
```
example update of user connection:
http verb: PUT  url: http://localhost:1337/users/56743397aa3babfd5bd45a8b
body:
{
  "connections": ["56743384aa3babfd5bd45a8a"]
}


example post of new user:
http verb: POST  url:https://hxxxxxxxx.herokuapp.com/users
body:
{
  "name": "Mattia Assogna",
  "profile_picture": "mypingpongpicture.jpg",
  "connections": [],
  "properties": ["5674404004dabd110041f850","56743f5004dabd110041f84e"]
}


example post of new property:
http verb: POST  url: https://hxxxxxxx.herokuapp.com/properties
body:
{
  "post_code": "AB1 0MG",
  "street_name": "High Road",
  "landlord_name": "Mr Fixer",
  "landlord_contact_details": "555 777 911",
  "property_type": "Flat",
  "number_of_flatmates": 1,
  "monthly_cost": 299,
  "deposit_amount": 200,
  "inclusive": false
}


example post of deleting property:
http verb: DELETE  url: http://localhost:1337/users/56743397aa3babfd5bd45a8b 

Are there any others you need?
```
I propose adding the following in order to meet the basic functionality of app:
```
1. Adding array of connection requests sent to user object
2. Adding array of connection requests received to user object
3. API call '/user_connection/user_id1/user_id2' POST (user_id1 to request connection to user_id2 ),
   PUT (to make connection), DELETE (to end connection)
4. Add one object for private details(rental history, current employment) 
   and another for public summary info including accommodation wants such as genral location, 
   rent range, date available. Private object hidden from request sent 
   and recived arrays in all requests.  Only can view in connection array.
5. General search of user objects by:
   Location
   Monthly rent that can pay
   Date when could move in
   Jobs
   Males / Females
   Interests
```

## Make the first get request on Swift 
#### branch used "3-link-swift-to-Api"

We are making the first get request in Swift to our DB using a dummy user profile.
We are using JSON and "SwiftyJSON" to manipulate the data.


## Run API test Using Below:
Tests added for api run `jasmine-node spec`.  Now working on adding social network functionality.


##Swift Login Using BAsic Auth to be Added

Later today I will update the api to include api login using basic auth see this [Using Basic auth with swift](http://stackoverflow.com/questions/24379601/how-to-make-an-http-request-basic-auth-in-swift)

The url that will need to be called is '/api/signin'

You can register(sign up) a user by creating a user object.

Then can signin using GET /api/signin and pass username:password using Basic Auth.  That user’s object will then be returned.

The returned user object contains the user.id .

This is now in production.

##Connection API Added
```
API call '/user_connection/user_id1/user_id2'
GET: CHECK a connection user2 is a connection of user1,
POST: send REQUEST for a connection from user1 to user2,
PUT: ACCEPT a connection request recd (user2) and request sent (user1) and add connections,
DELETE DISCONNECT a connection between user1 and user2
```

