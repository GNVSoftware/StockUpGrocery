# Project - Stockup

StockUp is a grocery carpooling application for college students only. 
Team: Franky Liang, Zhan Liang, Pranav Achanta

## User Stories

The following **required** functionality is complete:

- [ ] Users should be able to see people offering rides to the user's present location
- [ ] Settings page with filters.
- [ ] Ability to chat with each other
- [ ] Allow people offering rides to accept or decline a request
- [ ] User authentication - for now @ufl.edu
- [ ] User ratings - Driver and Rider

The following **optional** features are implemented:

- [ ] - Map view
- [ ] - Real time driver location
- [ ] - User and driver details
- [ ] - Location of grocery store
- [ ] - Store ratings, link to BOGO deals


## Wireframes

http://i.imgur.com/cGhjL9j.jpg
http://i.imgur.com/zqEnfo2.jpg
http://i.imgur.com/SEAejZV.jpg

## Suggested Schema

User - userid, email, password, rides, requests, rating
Rides - rideid, requests, spots left, lock status, time, price, destination
Requests - requestid, messages, requestrname, requestaddress, riderid, driverid
Message - requestid, rideid


## Video Walkthrough 

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