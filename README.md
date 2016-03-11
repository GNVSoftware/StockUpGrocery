# Project - Stockup

StockUp is a grocery carpooling application for college students only. 
Team: Franky Liang, Zhan Liang, Pranav Achanta

## User Stories

The following **required** functionality is complete:

- [ ] Passenger should be able to view all rides within 5 miles of his start point and  select one ride.
- [ ] Driver should be able to post a ride giving details store address, price and no of seats available.
- [ ] Nav Bar button goes to history of accepted rides
- [ ] User can see all the requests on a map with the passenger location as pins on the map.

The following **optional** features are implemented:

- [ ] Map view
- [ ] Real time driver location
- [ ] Store ratings, link to BOGO deals
- [ ] User ratings - Driver and Rider
- [ ] User authentication - for now @ufl.edu


## Wireframes

http://i.imgur.com/cGhjL9j.jpg
http://i.imgur.com/zqEnfo2.jpg
http://i.imgur.com/SEAejZV.jpg

## Suggested Schema

User     - userid, email, password, rides, requests, rating, phone number
Rides    - Rideid, DriverId, Spots Left, Time, Price, Destination
Requests - Requestid, Ride Id, PassengerId, Passenger address

## Video Walkthrough 
http://i.imgur.com/sbJrxS3.gif

Here's a walkthrough of implemented user stories:

<!--<img src='sample' title='Video Walkthrough for User Stories' width='' alt='Video Walkthrough' />-->

GIF created with [LiceCap](http://www.cockos.com/licecap/).


## Notes


## License

Copyright [2016] [Pranav Achanta]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
