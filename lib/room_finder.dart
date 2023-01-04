import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_form1/global.dart';

class RoomFinder extends StatefulWidget {
  const RoomFinder({super.key});
  @override
  State<RoomFinder> createState() => RoomFinderState();
}

class RoomFinderState extends State<RoomFinder> {
  final search = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  // save() async {
  //   final User? firebaseUser = firebaseAuth.currentUser;
  //   try {
  //     await firebaseAuth
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  List searchResult = [];
  void searchFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: query)
        .get();
    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 350,
                width: double.infinity,
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: const Center(
                  child: Text(
                    "Room Finder",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 32.5,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 250,
                  width: 350,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 221, 221),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 212, 210, 210),
                          offset: Offset(3, 3),
                          spreadRadius: 1,
                          blurRadius: 5,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                        child: Text(
                          "Find a property anywhere",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 22),
                        ),
                      ),

                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          key: _formkey,
                          controller: search,
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 20,
                              ),
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              hintText: 'Search room or near you'),
                          onChanged: (query) {
                            searchFirebase(query);
                          },
                        ),
                      ),

                      Center(
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                                fixedSize:
                                    MaterialStatePropertyAll(Size(300, 50))),
                            onPressed: () {
                              // Navigator.pushNamed(context, '/search');
                            },
                            child: const Text(
                              "Search Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            )),
                      ),
                      // ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "Advance Search",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(221, 37, 37, 37),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}

class Location {
  final String id;
  final String imageUrl;
  final String icon;
  final String title;
  final String subtitle;
  Location({
    required this.id,
    required this.imageUrl,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imageUrl = json['imageUrl'],
        icon = json['icon'],
        title = json['title'],
        subtitle = json['subtitle'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'icon': icon,
        'title': title,
        'subtitle': subtitle,
      };
}





























//   final List<Searching> search = [
//     Searching(id: '1', title: 'Flat'),
//     Searching(id: '2', title: 'Rooms'),
//     Searching(id: '3', title: 'Hall'),
//     Searching(id: '4', title: 'Rent'),
//     Searching(id: '5', title: 'House')
//   ];

//   final List<Room> rooms = [
//     Room(
//         id: '1',
//         title: '1 BHK at Lalitpur',
//         title1: 'Mahalaxmi Lalitpur',
//         title2: 'Available',
//         title3: 'Rs. 8000/',
//         title4: 'per month',
//         title5: '5 Applied | 10 Views',
//         icon1: Icons.location_on,
//         icon2: Icons.circle,
//         imageUrl:
//             "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
//     Room(
//         id: '2',
//         title: 'Big Room',
//         title1: 'Imadol',
//         title2: 'Unavailable',
//         title3: 'Rs. 5000/',
//         title4: 'per day',
//         title5: '9 Applied | 20Views',
//         icon1: Icons.location_on,
//         icon2: Icons.circle,
//         imageUrl:
//             "https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg"),
//     Room(
//         id: '3',
//         title: '4 Room for Student',
//         title1: 'Kupondole',
//         title2: 'Available',
//         title3: 'Rs. 6000/',
//         title4: 'per week',
//         title5: '10 Applied | 06 Views',
//         icon1: Icons.location_on,
//         icon2: Icons.circle,
//         imageUrl:
//             "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1e/a2/c7/26/the-standard-high-line.jpg?w=700&h=-1&s=1")
//   ];

//   final List<Update> updates =
//       List.of(jsonUpdate).map((e) => Update.fromJson(e)).toList();
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Column(children: [
//           Container(
//             padding: const EdgeInsets.all(1),
//             height: 350,
//             child: Stack(
//               children: [
//                 const SizedBox(
//                   height: 350,
//                   width: double.infinity,
//                 ),
//                 Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(30),
//                           bottomRight: Radius.circular(30))),
//                   child: const Center(
//                     child: Text(
//                       "Room Finder",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 100,
//                   left: 32.5,
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     height: 250,
//                     width: 350,
//                     decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 221, 221, 221),
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color.fromARGB(255, 212, 210, 210),
//                             offset: Offset(3, 3),
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                           )
//                         ]),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 30,
//                           child: Text(
//                             "Find a property anywhere",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black,
//                                 fontSize: 22),
//                           ),
//                         ),
//                         Container(
//                           height: 50,
//                           width: 300,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(10)),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pushNamed(context, '/searching');
//                             },
//                             child: TextField(
//                                 controller: searchTxt,
//                                 decoration: const InputDecoration(
//                                     labelStyle: TextStyle(
//                                       fontSize: 20,
//                                     ),
//                                     prefixIcon: Icon(
//                                       Icons.location_on,
//                                       color: Colors.red,
//                                     ),
//                                     hintText: 'Search address or near you')),
//                           ),
//                         ),

//                         Center(
//                           child: ElevatedButton(
//                               style: const ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStatePropertyAll(Colors.blue),
//                                   fixedSize:
//                                       MaterialStatePropertyAll(Size(300, 50))),
//                               onPressed: () {
//                                 Navigator.pushNamed(context, '/search');
//                               },
//                               child: const Text(
//                                 "Search Now",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 22,
//                                 ),
//                               )),
//                         ),
//                         // ),
//                         const SizedBox(
//                           height: 40,
//                           child: Text(
//                             "                             Advance Search",
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Color.fromARGB(221, 37, 37, 37),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             height: 50,
//             child: ListView.separated(
//                 shrinkWrap: true,
//                 itemCount: search.length,
//                 scrollDirection: Axis.horizontal,
//                 separatorBuilder: (context, index) => const Divider(
//                       indent: 35,
//                     ),
//                 itemBuilder: ((context, index) {
//                   return TextButton(
//                       style: ButtonStyle(
//                           backgroundColor: const MaterialStatePropertyAll(
//                             Color.fromARGB(255, 190, 187, 187),
//                           ),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(10)))),
//                       onPressed: () {},
//                       child: Text(
//                         search[index].title,
//                         style: const TextStyle(
//                           color: Colors.black54,
//                           fontSize: 20,
//                         ),
//                       ));
//                 })),
//           ),
//           SizedBox(
//             height: 70,
//             child: Row(children: [
//               const Text(
//                 " Recently Added Properties",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const Spacer(),
//               ElevatedButton(
//                   style: const ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(
//                           Color.fromARGB(255, 229, 226, 226))),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/view');
//                   },
//                   child: const Text(
//                     "View All ",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w400),
//                   ))
//             ]),
//           ),
//           ElevatedButton(
//             style: const ButtonStyle(
//               backgroundColor:
//                   MaterialStatePropertyAll(Color.fromARGB(255, 228, 225, 225)),
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, '/first');
//             },
//             child: SizedBox(
//               height: 150,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(5),
//                     height: 120,
//                     width: 405,
//                     decoration: const BoxDecoration(
//                         color: Color.fromARGB(255, 228, 225, 225),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(255, 235, 233, 233),
//                             offset: Offset(5, 5),
//                             blurRadius: 2,
//                             spreadRadius: 1,
//                           )
//                         ]),
//                   ),
//                   Positioned(
//                       left: 5,
//                       top: 15,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Image.network(
//                             "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
//                             height: 110,
//                           ))),
//                   Positioned(
//                     top: 30,
//                     left: 175,
//                     child: SizedBox(
//                         height: 100,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "1 BHK at Lalitpur",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 21),
//                             ),
//                             Row(
//                               children: const [
//                                 Text(
//                                   "Rs. 8000/",
//                                   style: TextStyle(
//                                       color: Color.fromARGB(255, 6, 29, 92),
//                                       fontSize: 22),
//                                 ),
//                                 Text(
//                                   "per month",
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     color: Color.fromARGB(255, 15, 14, 14),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Row(
//                               children: const [
//                                 Icon(
//                                   Icons.location_on,
//                                   color: Color.fromARGB(255, 4, 3, 88),
//                                   size: 15,
//                                 ),
//                                 Text(
//                                   "Mahalaxmi Lalitpur",
//                                   style: TextStyle(
//                                       color: Color.fromARGB(255, 15, 14, 14),
//                                       fontSize: 17),
//                                 )
//                               ],
//                             ),
//                           ],
//                         )),
//                   ),
//                   Positioned(
//                       top: 10,
//                       right: 10,
//                       child: Row(
//                         children: const [
//                           Icon(Icons.circle,
//                               size: 10,
//                               color: Color.fromARGB(255, 41, 175, 45)),
//                           Text(
//                             " Available",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 15, 14, 14),
//                                 fontSize: 18),
//                           )
//                         ],
//                       ))
//                 ],
//               ),
//             ),
//           ),
//           ElevatedButton(
//             style: const ButtonStyle(
//               backgroundColor:
//                   MaterialStatePropertyAll(Color.fromARGB(255, 228, 225, 225)),
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, '/second');
//             },
//             child: SizedBox(
//               height: 150,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(5),
//                     height: 120,
//                     width: 405,
//                     decoration: const BoxDecoration(
//                         color: Color.fromARGB(255, 228, 225, 225),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(255, 235, 233, 233),
//                             offset: Offset(5, 5),
//                             blurRadius: 2,
//                             spreadRadius: 1,
//                           )
//                         ]),
//                   ),
//                   Positioned(
//                       left: 5,
//                       top: 15,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Image.network(
//                             "https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg",
//                             height: 98,
//                           ))),
//                   Positioned(
//                     top: 30,
//                     left: 185,
//                     child: SizedBox(
//                         height: 100,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Big Room",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 21),
//                             ),
//                             Row(
//                               children: const [
//                                 Text(
//                                   "Rs. 5000/",
//                                   style: TextStyle(
//                                       color: Color.fromARGB(255, 6, 29, 92),
//                                       fontSize: 22),
//                                 ),
//                                 Text(
//                                   "per month",
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     color: Color.fromARGB(255, 15, 14, 14),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Row(
//                               children: const [
//                                 Icon(
//                                   Icons.location_on,
//                                   color: Color.fromARGB(255, 4, 3, 88),
//                                   size: 15,
//                                 ),
//                                 Text(
//                                   "Imadol",
//                                   style: TextStyle(
//                                       color: Color.fromARGB(255, 15, 14, 14),
//                                       fontSize: 17),
//                                 )
//                               ],
//                             ),
//                           ],
//                         )),
//                   ),
//                   Positioned(
//                       top: 10,
//                       right: 10,
//                       child: Row(
//                         children: const [
//                           Icon(
//                             Icons.circle,
//                             size: 10,
//                             color: Color.fromARGB(255, 192, 57, 47),
//                           ),
//                           Text(
//                             " Unavialable",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 15, 14, 14),
//                                 fontSize: 18),
//                           )
//                         ],
//                       ))
//                 ],
//               ),
//             ),
//           ),
//           ElevatedButton(
//             style: const ButtonStyle(
//               backgroundColor:
//                   MaterialStatePropertyAll(Color.fromARGB(255, 228, 225, 225)),
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, 'third');
//             },
//             child: SizedBox(
//               height: 150,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(5),
//                     height: 120,
//                     width: 405,
//                     decoration: const BoxDecoration(
//                         color: Color.fromARGB(255, 228, 225, 225),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(255, 235, 233, 233),
//                             offset: Offset(5, 5),
//                             blurRadius: 2,
//                             spreadRadius: 1,
//                           )
//                         ]),
//                   ),
//                   Positioned(
//                       left: 5,
//                       top: 15,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Image.network(
//                             "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1e/a2/c7/26/the-standard-high-line.jpg?w=700&h=-1&s=1",
//                             height: 115,
//                           ))),
//                   Positioned(
//                     top: 30,
//                     left: 185,
//                     child: SizedBox(
//                         height: 100,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "4 Room for Student",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 21),
//                             ),
//                             Row(
//                               children: const [
//                                 Text(
//                                   "Rs. 6000/",
//                                   style: TextStyle(
//                                       color: Color.fromARGB(255, 6, 29, 92),
//                                       fontSize: 22),
//                                 ),
//                                 Text(
//                                   "per month",
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     color: Color.fromARGB(255, 15, 14, 14),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Row(
//                               children: const [
//                                 Icon(
//                                   Icons.location_on,
//                                   color: Color.fromARGB(255, 4, 3, 88),
//                                   size: 15,
//                                 ),
//                                 Text(
//                                   "Kupondole",
//                                   style: TextStyle(
//                                       color: Color.fromARGB(255, 15, 14, 14),
//                                       fontSize: 17),
//                                 )
//                               ],
//                             ),
//                           ],
//                         )),
//                   ),
//                   Positioned(
//                       top: 10,
//                       right: 10,
//                       child: Row(
//                         children: const [
//                           Icon(Icons.circle,
//                               size: 10,
//                               color: Color.fromARGB(255, 41, 175, 45)),
//                           Text(
//                             " Available",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 15, 14, 14),
//                                 fontSize: 18),
//                           )
//                         ],
//                       ))
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 70,
//             child: Row(children: [
//               const Text(
//                 " Locations",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const Spacer(),
//               ElevatedButton(
//                   style: const ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(
//                           Color.fromARGB(255, 228, 225, 225))),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/SeeAll');
//                   },
//                   child: const Text(
//                     "View All ",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   )),
//             ]),
//           ),
//           SizedBox(
//               child: GridView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: locations.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.all(5),
//                       height: 500,
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Image.network(
//                               locations[index].imageUrl,
//                               height: 140,
//                             ),
//                           ),
//                           Positioned(
//                             left: 40,
//                             bottom: 30,
//                             child: Text(
//                               locations[index].title,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 0, 0, 0),
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 20),
//                             ),
//                           ),
//                           Positioned(
//                             left: 16,
//                             bottom: 10,
//                             child: Text(
//                               locations[index].subtitle,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Color.fromARGB(255, 26, 25, 24),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                               left: 10,
//                               bottom: 30,
//                               child: Icon(locations[index].icon,
//                                   color: Colors.red)),
//                         ],
//                       ),
//                     );
//                   })),
//           SizedBox(
//             height: 70,
//             child: Row(children: [
//               const Text(
//                 " Recent Updates",
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const Spacer(),
//               ElevatedButton(
//                   style: const ButtonStyle(
//                       backgroundColor:
//                           MaterialStatePropertyAll(Colors.transparent)),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/view');
//                   },
//                   child: const Text(
//                     "See All",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black54,
//                         fontWeight: FontWeight.w400),
//                   )),
//             ]),
//           ),
//           Container(
//             padding: const EdgeInsets.all(10),
//             child: ListView.separated(
//                 separatorBuilder: (context, index) => const Divider(
//                       height: 20,
//                     ),
//                 padding: const EdgeInsets.all(10),
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: updates.length,
//                 shrinkWrap: true,
//                 itemBuilder: ((context, index) {
//                   return ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                             const Color.fromARGB(255, 236, 229, 229))),
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/detail');
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Image.network(
//                             updates[index].imageUrl,
//                             height: 200,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               updates[index].title,
//                               style: const TextStyle(
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const Spacer(),
//                             Text(
//                               updates[index].price,
//                               style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black),
//                             )
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             ClipOval(
//                               child: Image.network(
//                                 updates[index].location,
//                                 height: 25,
//                               ),
//                             ),
//                             Text(
//                               updates[index].address,
//                               style: const TextStyle(
//                                 color: Color.fromARGB(255, 37, 35, 35),
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const Spacer(),
//                             Text(updates[index].views,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 37, 35, 35),
//                                   fontSize: 16,
//                                 ))
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               ClipOval(
//                                 child: Image.network(
//                                   updates[index].online,
//                                   height: 10,
//                                 ),
//                               ),
//                               Text(
//                                 updates[index].status,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 37, 35, 35),
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 })),
//           ),

//           // Card(
//           //   color: const Color.fromARGB(255, 235, 229, 229),
//           //   shadowColor: const Color.fromARGB(255, 192, 187, 187),
//           //   elevation: 20,
//           //   child: Container(
//           //     height: 300,
//           //     decoration: const BoxDecoration(
//           //       color: Color.fromARGB(255, 235, 229, 229),
//           //     ),
//           //     width: double.infinity,
//           //     padding: const EdgeInsets.all(10),
//           //     child: ElevatedButton(
//           //       style: ButtonStyle(
//           //           backgroundColor:
//           //               MaterialStateProperty.all(Colors.transparent)),
//           //       onPressed: () {
//           //         Navigator.pushNamed(context, '/info');
//           //       },
//           //       child: Column(
//           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //         children: [
//           //           ClipRRect(
//           //             borderRadius: BorderRadius.circular(15),
//           //             child: Image.network(
//           //               "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
//           //               height: 210,
//           //             ),
//           //           ),
//           //           Row(
//           //             children: const [
//           //               Text(
//           //                 " 1 BHK at Lalitpur",
//           //                 style: TextStyle(
//           //                   color: Colors.black87,
//           //                   fontWeight: FontWeight.w500,
//           //                   fontSize: 20,
//           //                 ),
//           //               ),
//           //               Spacer(),
//           //               Text(
//           //                 "Rs. 8000/",
//           //                 style: TextStyle(
//           //                     color: Color.fromARGB(255, 10, 15, 78),
//           //                     fontSize: 20),
//           //               ),
//           //               Text(
//           //                 "per month",
//           //                 style: TextStyle(
//           //                   color: Color.fromARGB(255, 37, 35, 35),
//           //                   fontSize: 16,
//           //                 ),
//           //               ),
//           //             ],
//           //           ),
//           //           Row(
//           //             children: const [
//           //               Icon(Icons.location_on,
//           //                   size: 20, color: Color.fromARGB(255, 10, 15, 78)),
//           //               Text(
//           //                 "Mahalaxmi Lalitpur",
//           //                 style: TextStyle(
//           //                   color: Color.fromARGB(255, 37, 35, 35),
//           //                   fontSize: 16,
//           //                 ),
//           //               ),
//           //               Spacer(),
//           //               Text("9 Applied | 20 Views",
//           //                   style: TextStyle(
//           //                     color: Color.fromARGB(255, 37, 35, 35),
//           //                     fontSize: 16,
//           //                   )),
//           //             ],
//           //           ),
//           //           Row(
//           //             children: const [
//           //               Icon(
//           //                 Icons.circle,
//           //                 size: 10,
//           //                 color: Colors.green,
//           //               ),
//           //               Text(
//           //                 " Available",
//           //                 style: TextStyle(
//           //                   color: Color.fromARGB(255, 37, 35, 35),
//           //                   fontSize: 16,
//           //                 ),
//           //               ),
//           //             ],
//           //           )
//           //         ],
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           // Card(
//           //   color: const Color.fromARGB(255, 235, 229, 229),
//           //   shadowColor: const Color.fromARGB(255, 192, 187, 187),
//           //   elevation: 20,
//           //   child: Container(
//           //     height: 300,
//           //     decoration: const BoxDecoration(
//           //       color: Color.fromARGB(255, 235, 229, 229),
//           //     ),
//           //     width: double.infinity,
//           //     padding: const EdgeInsets.all(10),
//           //     child: Column(
//           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //       children: [
//           //         ClipRRect(
//           //           borderRadius: BorderRadius.circular(15),
//           //           child: Image.network(
//           //             "https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg",
//           //             height: 210,
//           //           ),
//           //         ),
//           //         Row(
//           //           children: const [
//           //             Text(
//           //               " Big Room",
//           //               style: TextStyle(
//           //                 color: Colors.black87,
//           //                 fontWeight: FontWeight.w500,
//           //                 fontSize: 20,
//           //               ),
//           //             ),
//           //             Spacer(),
//           //             Text(
//           //               "Rs. 5000/",
//           //               style: TextStyle(
//           //                   color: Color.fromARGB(255, 10, 15, 78),
//           //                   fontSize: 20),
//           //             ),
//           //             Text(
//           //               "per day",
//           //               style: TextStyle(
//           //                 color: Color.fromARGB(255, 37, 35, 35),
//           //                 fontSize: 16,
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //         Row(
//           //           children: const [
//           //             Icon(Icons.location_on,
//           //                 size: 20, color: Color.fromARGB(255, 10, 15, 78)),
//           //             Text(
//           //               "Imadol",
//           //               style: TextStyle(
//           //                 color: Color.fromARGB(255, 37, 35, 35),
//           //                 fontSize: 16,
//           //               ),
//           //             ),
//           //             Spacer(),
//           //             Text("5 Applied | 10 Views",
//           //                 style: TextStyle(
//           //                   color: Color.fromARGB(255, 37, 35, 35),
//           //                   fontSize: 16,
//           //                 )),
//           //           ],
//           //         ),
//           //         Row(
//           //           children: const [
//           //             Icon(
//           //               Icons.circle,
//           //               size: 10,
//           //               color: Colors.red,
//           //             ),
//           //             Text(
//           //               " Unavailable",
//           //               style: TextStyle(
//           //                 color: Color.fromARGB(255, 37, 35, 35),
//           //                 fontSize: 16,
//           //               ),
//           //             ),
//           //           ],
//           //         )
//           //       ],
//           //     ),
//           //   ),
//           // ),
//           // Card(
//           //   color: const Color.fromARGB(255, 235, 229, 229),
//           //   shadowColor: const Color.fromARGB(255, 192, 187, 187),
//           //   elevation: 20,
//           //   child: Container(
//           //     height: 300,
//           //     decoration: const BoxDecoration(
//           //       color: Color.fromARGB(255, 235, 229, 229),
//           //     ),
//           //     width: double.infinity,
//           //     padding: const EdgeInsets.all(10),
//           //     child: Column(
//           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //       children: [
//           //         ClipRRect(
//           //           borderRadius: BorderRadius.circular(15),
//           //           child: Image.network(
//           //             "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1e/a2/c7/26/the-standard-high-line.jpg?w=700&h=-1&s=1",
//           //             height: 210,
//           //           ),
//           //         ),
//           //         Row(
//           //           children: const [
//           //             Text(
//           //               " 4 Room for Student",
//           //               style: TextStyle(
//           //                 color: Colors.black87,
//           //                 fontWeight: FontWeight.w500,
//           //                 fontSize: 20,
//           //               ),
//           //             ),
//           //             Spacer(),
//           //             Text(
//           //               "Rs. 6000/",
//           //               style: TextStyle(
//           //                   color: Color.fromARGB(255, 10, 15, 78),
//           //                   fontSize: 20),
//           //             ),
//           //             Text(
//           //               "per week",
//           //               style: TextStyle(
//           //                 color: Color.fromARGB(255, 37, 35, 35),
//           //                 fontSize: 16,
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //         Row(
//           //           children: const [
//           //             Icon(Icons.location_on,
//           //                 size: 20, color: Color.fromARGB(255, 10, 15, 78)),
//           //             Text(
//           //               "Kupondole",
//           //               style: TextStyle(
//           //                 color: Color.fromARGB(255, 37, 35, 35),
//           //                 fontSize: 16,
//           //               ),
//           //             ),
//           //             Spacer(),
//           //             Text("10 Applied | 06 Views",
//           //                 style: TextStyle(
//           //                   color: Color.fromARGB(255, 37, 35, 35),
//           //                   fontSize: 16,
//           //                 )),
//           //           ],
//           //         ),
//           //         Row(
//           //           children: const [
//           //             Icon(
//           //               Icons.circle,
//           //               size: 10,
//           //               color: Colors.green,
//           //             ),
//           //             Text(
//           //               " Available",
//           //               style: TextStyle(
//           //                 color: Color.fromARGB(255, 37, 35, 35),
//           //                 fontSize: 16,
//           //               ),
//           //             ),
//           //           ],
//           //         )
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ]));
//   }
// }

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Search Detail",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: SearchNow(),
//     );
//   }
// }

// class LocationView extends StatelessWidget {
//   const LocationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ViewLocation(),
//     );
//   }
// }

// class ViewPage extends StatelessWidget {
//   const ViewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(""),
//       ),
//       body: const ViewAll(),
//     );
//   }
// }

// class FirstPage extends StatelessWidget {
//   const FirstPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: MahalaxmiLalitpur(),
//     );
//   }
// }

// class SecondPage extends StatelessWidget {
//   const SecondPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BigRoom(),
//     );
//   }
// }

// class ThirdPage extends StatelessWidget {
//   const ThirdPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StudentRoom(),
//     );
//   }
// }

// class NextPage extends StatelessWidget {
//   const NextPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: SearchAddress(),
//       ),
//     );
//   }
// }

// class FourthPage extends StatelessWidget {
//   const FourthPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Recent Updates"),
//       ),
//       body: RoomPage(),
//     );
//   }
// }

// class Room {
//   final String id;
//   final String title;
//   final String title1;
//   final String title2;
//   final String title3;
//   final String title4;
//   final String title5;
//   final String icon1;
//   final String icon2;
//   final String imageUrl;
//   Room({
//     required this.id,
//     required this.title,
//     required this.title1,
//     required this.title2,
//     required this.title3,
//     required this.title4,
//     required this.title5,
//     required this.icon1,
//     required this.icon2,
//     required this.imageUrl,
//   });
//   Room.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         title = json['title'],
//         title1 = json['title1'],
//         title2 = json['title2'],
//         title3 = json['title3'],
//         title4 = json['title4'],
//         title5 = json['title5'],
//         icon1 = json['icon1'],
//         icon2 = json['iocn2'],
//         imageUrl = json['imageurl'];
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'title1': title1,
//         'title2': title2,
//         'title3': title3,
//         'title4': title4,
//         'title5': title5,
//         'icon1': icon1,
//         'icon2': icon2,
//         'imageUrl': imageUrl,
//       };
// }

// 
// class Searching {
//   final String id;
//   final String title;
//   Searching({
//     required this.id,
//     required this.title,
//   });
// }


// class FifthPage extends StatelessWidget {
//   const FifthPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RoomDetail(),
//     );
//   }
// }

// class SixthPage extends StatelessWidget {
//   const SixthPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Room Detail"),
//       ),
//       body: RoomInformation(),
//     );
//   }
// }

// class Update {
//   final int id;
//   final String title;

//   final String views;
//   final String price;
//   final String address;
//   final String status;
//   final String location;
//   final String online;
//   final String imageUrl;
//   Update({
//     required this.id,
//     required this.title,
//     required this.views,
//     required this.price,
//     required this.address,
//     required this.status,
//     required this.location,
//     required this.online,
//     required this.imageUrl,
//   });

//   Update.fromJson(Map<String, dynamic> json)
//       : id = json["id"],
//         title = json["title"],
//         views = json["views"],
//         price = json["price"],
//         address = json["address"],
//         status = json["status"],
//         location = json["location"],
//         online = json["online"],
//         imageUrl = json["imageUrl"];
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'views': views,
//         'price': price,
//         'address': address,
//         'status': status,
//         'location': location,
//         'online': online,
//         'imageUrl': imageUrl,
//       };
// }

// final jsonUpdate = [
//   {
//     'id': 1,
//     'title': "1 BHK at Lalitpur",
//     'views': "10 Applied | 20 views",
//     'price': "Rs.10000 / per day",
//     'address': "Lalitpur",
//     'status': "Available",
//     'location':
//         "https://static.vecteezy.com/system/resources/previews/004/897/637/original/location-red-icon-simple-design-free-vector.jpg",
//     'online':
//         "https://p.kindpng.com/picc/s/406-4066806_clipart-circle-green-green-circle-image-png-transparent.png",
//     'imageUrl':
//         "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&w=1000&q=80"
//   },
//   {
//     'id': 2,
//     'title': "Big Room",
//     'views': "20 Applied | 40 views",
//     'price': "Rs.20000 / per day",
//     'address': "Imadol",
//     'status': "Available",
//     'location':
//         "https://static.vecteezy.com/system/resources/previews/004/897/637/original/location-red-icon-simple-design-free-vector.jpg",
//     'online':
//         "https://p.kindpng.com/picc/s/406-4066806_clipart-circle-green-green-circle-image-png-transparent.png",
//     'imageUrl':
//         "https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg"
//   },
//   {
//     'id': 3,
//     'title': "Hall and Room",
//     'views': "5 Applied | 8 views",
//     'price': "Rs.40000 / per week",
//     'address': "Bhaktapur",
//     'status': "Available",
//     'location':
//         "https://static.vecteezy.com/system/resources/previews/004/897/637/original/location-red-icon-simple-design-free-vector.jpg",
//     'online':
//         "https://p.kindpng.com/picc/s/406-4066806_clipart-circle-green-green-circle-image-png-transparent.png",
//     'imageUrl':
//         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1e/a2/c7/26/the-standard-high-line.jpg?w=700&h=-1&s=1"
//   }
// ];
