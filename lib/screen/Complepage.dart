import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/auth_screen/Login.dart';
import 'package:quizapp/screen/home.dart';
class Complepage extends StatelessWidget {

  final int correctAnswers;
  final int wrongAnswers;
  const Complepage({super.key, required this.correctAnswers, required this.wrongAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
         children: [
           SizedBox(
             height: 521,
              width: 400,
             child: Stack(
               children: [
                 Container(
                   height: 340,
                   width: 410,
                    decoration: BoxDecoration(
                      color: const Color(0xff40E0D0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                   child: Center(
                     child: CircleAvatar(
                       radius: 85,
                         backgroundColor: Colors.white.withOpacity(.3),
                       child: CircleAvatar(
                         radius: 71,
                          backgroundColor: Colors.white.withOpacity(.4),
                         child: CircleAvatar(
                           radius: 60,
                           backgroundColor: Colors.white,
                           child: Center(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 const Text(
                                     "Your Score",
                                   style: TextStyle(
                                     fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                   ),
                                 ),

                                 RichText(
                                     text:  TextSpan(
                                       text:'$correctAnswers',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                           fontSize: 20,
                                          color: Colors.black
                                        ),

                                       children: const [
                                         TextSpan(
                                         text:' /10',
                                         style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontSize: 20,
                                             color: Colors.black
                                          ),
                                         ),
                                       ]
                                     ),
                                 )
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),

                 Positioned(
                   bottom: 60,
                     left: 10,
                     child: Container(
                       height: 190,
                        width: 340,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(20),
                         boxShadow: [
                           BoxShadow(
                             blurRadius: 5,
                             spreadRadius: 3,
                             color: const Color(0xff40E0D0).withOpacity(.7),
                             offset: const Offset(0,1)
                           )
                         ]
                       ),

                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Row(
                                            children: [
                                            Container(
                                            height: 15,
                                            width: 15,
                                            decoration: const BoxDecoration(
                                              color:  Color(0xff40E0D0),
                                              shape: BoxShape.circle
                                               ),
                                              ),

                                              const Text(
                                                  '100%',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color:  Color(0xff40E0D0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        
                                       const Text(
                                           "Completion",
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold
                                         ),
                                       )
                                      ],
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: const BoxDecoration(
                                                    color:  Color(0xff40E0D0),
                                                    shape: BoxShape.circle
                                                ),
                                              ),

                                              const Text(
                                                '10',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color:  Color(0xff40E0D0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        const Text(
                                          "Total Questions",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),

                                const SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: const BoxDecoration(
                                                    color:  Colors.green,
                                                    shape: BoxShape.circle
                                                ),
                                              ),

                                               Text(
                                                '$correctAnswers',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color:  Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        const Text(
                                          "Correct",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 60.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: const BoxDecoration(
                                                      color:  Colors.red,
                                                      shape: BoxShape.circle
                                                  ),
                                                ),
                                      
                                                 Text(
                                                  ' $wrongAnswers',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:  Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                      
                                          const Text(
                                            "Wrong",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                       ),
                     ),
                 )
               ],
             ),
           ),



           const SizedBox(
             height: 100.0,
           ),

            Center(
             child:Padding(
               padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       children: [
                         InkWell(
                           onTap:(){
                             Navigator.push(context,MaterialPageRoute(builder: (context)=> const HomePage()));
                           },
                           child: const CircleAvatar(
                              backgroundColor: Color(0xffFD5E53),
                             radius: 35,
                             child: Center(
                               child: Icon(
                                 Icons.refresh,
                                 size: 35,
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(height: 10,),
                         const Text(
                             "Play Again",
                           style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.bold
                           ),
                         ),
                       ],
                     ),


                      Column(
                       children: [
                         InkWell(
                           onTap:() async {
                             await FirebaseAuth.instance.signOut();
                             Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginPage()));
                           },
                           child: CircleAvatar(
                             backgroundColor: Color(0xffda94e3),
                             radius: 35,
                             child: Center(
                               child: Icon(
                                 Icons.exit_to_app_outlined,
                                 size: 35,
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         ),
                         SizedBox(height: 10,),
                         Text(
                           "LogOut",
                           style: TextStyle(
                               fontSize: 15,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                       ],
                     ),
                   ],
                ),
             ),
           ),



         ],
       ),
    );
  }
}
