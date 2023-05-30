import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:spark/main.dart';

class Services extends StatefulWidget {
  const Services({Key key}) : super(key: key);

  @override
  _ServicesPage createState() => _ServicesPage();
}

class _ServicesPage extends State<Services> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 22, 59, 1),
        title: Text("TERMES & CONDITIONS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x39000000),
                      offset: Offset(0, -1),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      // height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F5F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 24, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime, repellat voluptatum, doloribus eligendi quo reprehenderit officiis fugit reiciendis tenetur aspernatur labore blanditiis, rerum minus modi inventore cupiditate voluptates corrupti non. Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aperiam dolor animi minus quidem tempore quod, pariatur recusandae qui nemo hic odit, sed dicta ducimus alias ad aliquam debitis. At,  asperiores?  Lorem ipsum dolor sit, amet consectetur adipisicing elit. Incidunt corrupti odit nisi earum officiis eaque inventore sequi, asperiores optio voluptas sunt explicabo quis! Est sit accusantium deserunt soluta id nam. Lorem, ipsum dolor sit amet consectetur adipisicing elit. Suscipit maxime magnam delectus. Molestiae deleniti, sunt incidunt aspernatur non ratione, distinctio tempore beatae inventore, animi pariatur placeat ad voluptatum minima reprehenderit. Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nesciunt, soluta repellat? Assumenda delectus quasi optio eum excepturi? Nobis esse, laborum consequuntur fugit, maiores illum placeat temporibus officia ab qui consectetur?Lorem ipsum dolor, sit amet consectetur adipisicing elit. Cumque architecto dignissimos soluta, laborum similique commodi eum ea nulla impedit magni sed omnis labore minima? Necessitatibus totam beatae molestias vitae praesentium. Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa ullam officia consequatur saepe nemo ut asperiores aut perspiciatis nisi dignissimos, mollitia voluptatem sapiente consectetur dolore possimus blanditiis dolor ipsam non? Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius minus velit aut possimus architecto eveniet sunt repudiandae, ea sed provident maxime tempore iusto dolore corrupti culpa? Odio harum reiciendis unde! Lorem ipsum dolor, sit amet consectetur adipisicing elit. Officiis sint delectus perspiciatis quibusdam impedit possimus cum quas maiores quos et. Placeat laboriosam cupiditate velit voluptatibus itaque sequi excepturi consequatur? Natus! Lorem ipsum dolor sit amet consectetur adipisicing elit. Iste recusandae suscipit iusto, placeat repellendus distinctio saepe, voluptatum fuga dignissimos unde culpa. Expedita, autem dolorum? Officiis ipsum ratione ducimus autem explicabo!",
                                      style: TextStyle(
                                          color: Color(0xFF090F13),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
